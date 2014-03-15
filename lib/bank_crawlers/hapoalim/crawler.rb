require 'hpricot'
require 'capybara/poltergeist'

class String
  def dateify
    Date.parse("#{self} 2014")
  end

  def numerify
    self.gsub(/[,.]/, '').to_i/100.0
  end
end

class Hpricot::Elem
  def clean_text
    search('script').remove
    inner_text
  end
end

module BankCrawlers::Hapoalim

  Parser = Struct.new :html do
    def transactions
      table.map do |row|
        parse_row(row)
      end
    end

    def balance
      transactions.last[:balance]
    end

    private

    def parse_row row
      items = row.search('td')
      {
        created_at: items.shift.clean_text.dateify,
        description: items.shift.clean_text,
        number: items.shift.clean_text,
        confirmed_at: items.shift.clean_text.dateify,
        amount: items.shift.clean_text.numerify,
        extra_info: items.shift.clean_text,
        balance: items.shift.clean_text.numerify
      }
    end

    def table
      doc.search('.TR_ROW_BANKTABLE')
    end

    def doc
      @doc ||= Hpricot(html)
    end
  end

  Runner = Struct.new :user_name, :user_id, :password do
    def run
      parser.transactions
    end

    private

    def parser
      Parser.new(transactions_html)
    end

    def transactions_html
      cache.get or cache.set(crawler.transaction_table)
    end

    def cache
      Cache.new
    end

    def crawler
      Crawler.new user_name, user_id, password
    end
  end

  class Cache

    def get
      todays_transaction_table_file.read if todays_transaction_table_file.exist?
    end

    def set transaction_table
      FileUtils.makedirs(dir)
      File.write todays_transaction_table_file, transaction_table
      transaction_table
    end

    private

    def todays_transaction_table_file
      Pathname "tmp/transactions-#{Date.today}.html"
    end

    def dir
      "tmp"
    end
  end

  class InvalidCredentials < StandardError
  end

  class Crawler
    include Capybara::DSL

    BASE_URL = "https://login.bankhapoalim.co.il/cgi-bin/poalwwwc"
    @@urls = {
      login: "/?language=EN"
    }

    attr_reader :user_name, :user_id, :password
    def initialize user_name, user_id, password
      @user_name, @user_id, @password = [user_name, user_id, password]
      Capybara.run_server = false
      Capybara.current_driver = :poltergeist
      Capybara.app_host = BASE_URL
    end

    def transaction_table
      login
      iframe_body
    end

    private

    def login
      visit @@urls[:login]
      fill_in :userid, with: user_name
      fill_in :id, with: user_id
      fill_in :password, with: password

      click_button 'Sign In'
      sleep 10
      raise InvalidCredentials if page.body =~ /Welcome to Hapoalim online/
    end

    def iframe_body
      within_frame "BODY" do
        return page.body
      end
    end
  end
end

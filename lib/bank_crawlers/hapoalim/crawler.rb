require 'capybara/poltergeist'

module BankCrawlers::Hapoalim

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

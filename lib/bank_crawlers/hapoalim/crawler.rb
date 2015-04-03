require 'capybara/dsl'
require 'capybara/poltergeist'

module BankCrawlers::Hapoalim

  class InvalidCredentials < StandardError
  end

  class Crawler
    include Capybara::DSL
    BASE_URL = "https://login.bankhapoalim.co.il/cgi-bin/poalwwwc"

    attr_reader :user_name, :password
    def initialize *params
      @user_name, @password = params
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
      visit 'https://login.bankhapoalim.co.il/cgi-bin/poalwwwc?reqName=getLogonPage&TYPE=33554432&REALMOID=06-c69c66f9-410d-4bf6-97ed-cda19dfe9525&GUID=&SMAUTHREASON=0&METHOD=GET&SMAGENTNAME=-SM-1HNbaIFTTNjxn%2bA0EVBZ5gOJ8m0FeXOt6VJLKKVGSDR%2bSimot3C2VnK%2bwnLF5QAj&TARGET=-SM-HTTPS%3a%2f%2flogin%2ebankhapoalim%2eco%2eil%2fcgi--bin%2fpoalwwwc%3fdt%3d924%26nls%3dEN'
      find('#userID').set(user_name)
      find('#userPassword').set(password)

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

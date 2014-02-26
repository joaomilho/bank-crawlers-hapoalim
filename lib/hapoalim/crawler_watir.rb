#https://login.bankhapoalim.co.il/cgi-bin/poalwwwc/?&reqName=&ctfw=init&reqName=action&language=EN&transactionId=Last60TransactionsInEng&subMenuName=Shekel&ts=077607&tf=0.11931206029839814&pSubMenu=undefined&fromSubMenu=Shekel&bxx=912&nsv=y&dwx=876271950679736399&wScr=1280&hScr=800&mmx=2&qwrt=077607&dtcdb=3518486&menuTranName=Last60TransactionsInEng

require 'capybara/poltergeist'

module BankCrawlers
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

    def crawl
      login

      #download_excel
    end

    private

    delegate :frame, :goto, :text_field, :button, to: :browser
    def login
      visit @@urls[:login]
      fill_in :userid, with: user_name
      fill_in :id, with: user_id
      fill_in :password, with: password
      save_screenshot "before.png"

      click_button 'Sign In'


    end

  end
end

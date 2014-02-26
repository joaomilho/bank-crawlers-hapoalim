require 'hpricot'
require 'capybara/poltergeist'

include Capybara::DSL

BASE_URL = "https://login.bankhapoalim.co.il/cgi-bin/poalwwwc"

user_name, user_id, password = *ARGV
Capybara.run_server = false
Capybara.current_driver = :poltergeist
Capybara.app_host = BASE_URL
visit "/?language=EN"
fill_in :userid, with: user_name
fill_in :id, with: user_id
fill_in :password, with: password

click_button 'Sign In'
sleep 10

doc = nil
within_frame "BODY" do
  doc = Hpricot(page.body)
end

transactions = doc.search('.TR_ROW_BANKTABLE').map do |tr|
  tr.search('td').map do |td|
    td.search('script').remove
    td.inner_text
  end
end

puts transactions.last.last.gsub(/[,.]/, '').to_i/100.0

require_relative 'spec_helper'

include BankCrawlers::Hapoalim

describe Crawler do
  describe "#transaction_table", :vcr do
    context 'given valid auth data' do
      subject(:crawler) do
        Cache.new.clear
        Crawler.new 'WE05084', '337735658', 'aagn3392'
      end

      it 'gets transaction table from online bank' do
        title = (Hpricot(crawler.transaction_table) % 'title').inner_text
        title[0] = '' # Remove first trash character
        expect(title).to eq("Account transactions")
      end
    end

    # context 'given invalid auth data' do
    #   subject(:crawler) do
    #     Crawler.new 'bogus', 'bogus', 'bogus'
    #   end
    #
    #   it 'raises InvalidCredentials' do
    #     expect(crawler.transaction_table).to raise(InvalidCredentials)
    #   end
    # end
  end
end

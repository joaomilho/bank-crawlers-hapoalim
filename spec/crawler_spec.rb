require_relative 'spec_helper'

include BankCrawlers::Hapoalim

describe Crawler, vcr: true do
  describe "#transaction_table" do
    context 'given valid auth data' do
      subject(:crawler) do
        raise "You should set credentials in your ENV to run this test" unless ENV['HAPOALIM_USER']
        Crawler.new ENV['HAPOALIM_USER'], ENV['HAPOALIM_ID'], ENV['HAPOALIM_PASSWORD']
      end

      it 'gets transaction table from online bank' do
        title = (Hpricot(crawler.transaction_table) % 'title').inner_text
        title[0] = '' # Remove first trash character
        expect(title).to eq("Account transactions")
      end
    end

    context 'given invalid auth data' do
      subject(:crawler) do
        Crawler.new 'bogus', 'bogus', 'bogus'
      end

      it 'raises InvalidCredentials' do
        expect{ crawler.transaction_table }.to raise_error(InvalidCredentials)
      end
    end
  end
end

require_relative 'spec_helper'

include BankCrawlers::Hapoalim

describe Cache do
  describe ".get" do
    subject(:cache){ Cache.new }

    before do
      cache.set("HEY")
    end

    it "should keep cache today" do
      expect(cache.get).to eq("HEY")
    end

    it "should not keep cache tomorrow" do
      Timecop.freeze(Date.today + 1) do
        expect(cache.get).not_to eq("HEY")
      end
    end
  end
end

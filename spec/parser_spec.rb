require_relative 'spec_helper'

include BankCrawlers::Hapoalim

describe Parser do
  let(:html) { File.read(Dir.pwd + "/spec/fixtures/transactions.html") }

  subject(:parser) do
    Parser.new(html)
  end

  describe "#balance" do
    it "should get the last amount" do
      expect(parser.balance).to eq(43153.06)
    end
  end

  describe "#transactions" do
    it "should have 2 transactions" do
      expect(parser.transactions.length).to be(2)
    end
  end
end

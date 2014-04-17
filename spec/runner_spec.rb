require_relative 'spec_helper'

include BankCrawlers::Hapoalim

describe Runner do
  let(:html) { File.read(Dir.pwd + "/spec/fixtures/transactions.html") }

  subject(:runner) do
    Runner.new 'user', 'id', 'pass'
  end

  describe "#run" do
    context 'given cache is empty' do
      before do
        Cache.new.clear
      end

      it 'gets from the crawler' do
        allow_any_instance_of(Crawler).to receive(:transaction_table).and_return(html)
        runner.run
      end
    end

    context 'given cache is set' do
      before do
        Cache.new.set("!")
      end

      it 'gets from the cache' do
        allow_any_instance_of(Cache).to receive(:get).and_return(html)
        runner.run
      end
    end
  end
end

module BankCrawlers::Hapoalim

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

end

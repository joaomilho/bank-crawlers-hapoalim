module BankCrawlers::Hapoalim
  class Cache
    def get
      todays_transaction_table_file.read if todays_transaction_table_file.exist?
    end

    def set transaction_table
      FileUtils.makedirs(dir)
      File.write todays_transaction_table_file, transaction_table
      transaction_table
    end

    def clear
      File.unlink todays_transaction_table_file
    end

    private

    def todays_transaction_table_file
      Pathname "tmp/transactions-#{Date.today}.html"
    end

    def dir
      "tmp"
    end
  end
end

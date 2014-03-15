require 'hpricot'

module BankCrawlers::Hapoalim

  Parser = Struct.new :html do
    def transactions
      table.map do |row|
        parse_row(row)
      end.compact
    end

    def balance
      transactions.last[:balance]
    end

    private

    def parse_row row
      items = row.search('td')
      puts "ROW ITEMS"
      puts items.inspect
      {
        created_at: items.shift.clean_text.dateify,
        description: items.shift.clean_text,
        number: items.shift.clean_text,
        confirmed_at: items.shift.clean_text.dateify,
        amount: items.shift.clean_text.numerify,
        extra_info: items.shift.clean_text,
        balance: items.shift.clean_text.numerify
      }
    rescue
      nil
    end

    def table
      doc.search('.TR_ROW_BANKTABLE')
    end

    def doc
      @doc ||= Hpricot(html)
    end
  end

end

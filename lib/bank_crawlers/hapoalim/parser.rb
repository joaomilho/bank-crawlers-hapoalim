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
      items = row.search('td').map(&:clean_text)
      {
        created_at:   items.shift.dateify,
        description:  items.shift
        number:       items.shift,
        confirmed_at: items.shift.dateify,
        amount:       items.shift.numerify,
        extra_info:   items.shift,
        balance:      items.shift.numerify
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

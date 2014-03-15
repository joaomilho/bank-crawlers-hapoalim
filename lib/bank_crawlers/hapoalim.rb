module BankCrawlers
  module Hapoalim
    def self.run user_name, user_id, password
      Runner.new(user_name, user_id, password).run
    end
  end
end

require_relative 'hapoalim/crawler'
require_relative 'hapoalim/version'

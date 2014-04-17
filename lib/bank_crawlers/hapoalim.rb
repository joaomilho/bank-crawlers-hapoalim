module BankCrawlers
  module Hapoalim
    def self.run user_name, user_id, password
      Runner.new(user_name, user_id, password).run
    end
  end
end

require_relative 'hapoalim/string_patches'
require_relative 'hapoalim/hpricot_patches'
require_relative 'hapoalim/parser'
require_relative 'hapoalim/runner'
require_relative 'hapoalim/cache'
require_relative 'hapoalim/crawler'

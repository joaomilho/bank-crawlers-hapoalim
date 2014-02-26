#require 'watir-webdriver'
require 'active_support/core_ext/module'
require_relative 'hapoalim/crawler'

module BankCrawlers
  module Hapoalim
    def self.crawl user_name, user_id, password
      Crawler.new(user_name, user_id, password).crawl
    end
  end
end

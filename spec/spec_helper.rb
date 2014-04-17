$:.unshift File.expand_path("../../lib/bank_crawlers", __FILE__)

require 'bundler/setup'
require 'hpricot'
require 'timecop'
require 'vcr'
require 'hapoalim'
require 'webmock'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

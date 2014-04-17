$:.unshift File.expand_path("../../lib/bank_crawlers", __FILE__)

require 'bundler/setup'
require 'hpricot'
require 'timecop'
require 'vcr'
require 'hapoalim'
require 'webmock'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = false
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

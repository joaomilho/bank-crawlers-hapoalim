require_relative 'lib/bank_crawlers/hapoalim'

# Usage:
#
# ruby run.rb USER TEUDAT_ZEUT PASSWORD

BankCrawlers::Hapoalim.run *ARGV

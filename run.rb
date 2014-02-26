require_relative 'lib/hapoalim'

# Usage:
#
# ruby run.rb USER TEUDAT_ZEUT PASSWORD

BankCrawlers::Hapoalim.crawl *ARGV

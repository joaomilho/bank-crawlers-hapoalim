# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hapoalim/version'

Gem::Specification.new do |spec|
  spec.name          = "bank-crawlers-hapoalim"
  spec.version       = BankCrawlers::Hapoalim::VERSION
  spec.authors       = ["Maiz Lulkin"]
  spec.email         = ["maiz@lulk.in"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~>2.14"
  spec.add_development_dependency "vcr"

  spec.add_dependency "poltergeist"
  spec.add_dependency "active_support"
end
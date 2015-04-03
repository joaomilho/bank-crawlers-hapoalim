# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "bank-crawlers-hapoalim"
  spec.version       = '0.0.6'
  spec.authors       = ["Maiz Lulkin"]
  spec.email         = ["maiz@lulk.in"]
  spec.description   = %q{A crappy crawler for a crappy bank interface}
  spec.summary       = %q{A crappy crawler for a crappy bank interface. Deal with it.}
  spec.homepage      = "https://github.com/joaomilho/bank-crawlers-hapoalim"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"

  spec.add_development_dependency "rake", '~> 0'
  spec.add_development_dependency "rspec", "~>2.14"
  spec.add_development_dependency "timecop", '~> 0'
  spec.add_development_dependency "pry", '~> 0'

  spec.add_dependency "capybara", '~> 2.4.4'
  spec.add_dependency "poltergeist", '~> 1.6'
  spec.add_dependency "hpricot", '~> 0'
end

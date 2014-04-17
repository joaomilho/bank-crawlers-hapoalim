# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "bankcrawlers-hapoalim"
  spec.version       = '0.0.5'
  spec.authors       = ["Maiz Lulkin"]
  spec.email         = ["maiz@lulk.in"]
  spec.description   = %q{A crappy crawler for a crappy bank interface}
  spec.summary       = %q{A crappy crawler for a crappy bank interface}
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
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "psych"

  spec.add_dependency "capybara"
  spec.add_dependency "poltergeist"
  spec.add_dependency "hpricot"
end

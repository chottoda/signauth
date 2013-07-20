# -*- encoding: utf-8 -*-
require File.expand_path('../lib/signauth/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["arukoh"]
  gem.email         = ["arukoh10@gmail.com"]
  gem.description   = %q{Signature authentication}
  gem.summary       = %q{Signature authentication}
  gem.homepage      = "https://github.com/arukoh/signauth"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "signauth"
  gem.require_paths = ["lib"]
  gem.version       = Signauth::VERSION
  gem.license       = 'MIT'

  gem.add_development_dependency "rake", ">= 0.8.7"
  gem.add_development_dependency "rspec", ">= 2.4.0"
end

# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gbwd/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Thomas Brewer"]
  gem.email         = ["tom@21purple.com"]
  gem.description   = %q{Command line tool for the highly performant and scalable GBWD service}
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = %w(gbwd)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gbwd"
  gem.require_paths = ["lib"]
  gem.version       = Gbwd::VERSION
  gem.add_development_dependency('fakefs')
  gem.add_development_dependency('rspec')
  gem.add_dependency('subcommand')
end

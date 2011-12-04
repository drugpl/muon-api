# -*- encoding: utf-8 -*-
require File.expand_path('../lib/muon-api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Paweł Pacana"]
  gem.email         = ["pawel.pacana@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "muon-api"
  gem.require_paths = ["lib"]
  gem.version       = Muon::API::VERSION

  gem.add_dependency 'grape'
  gem.add_dependency 'mongoid'
  gem.add_dependency 'bson_ext'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'database_cleaner'
  gem.add_development_dependency 'timecop'
  gem.add_development_dependency 'rake'
end

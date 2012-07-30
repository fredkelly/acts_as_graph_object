# -*- encoding: utf-8 -*-
require File.expand_path('../lib/acts_as_graph_object/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Fred Kelly"]
  gem.email         = ["me@fredkelly.net"]
  gem.description   = %q{ActiveRecord extension that maps models to Facebook Open Graph objects.}
  gem.summary       = %q{Facebook Open Graph object mapper.}
  gem.homepage      = "https://github.com/fredkelly/acts_as_graph_object"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "acts_as_graph_object"
  gem.require_paths = ["lib"]
  gem.version       = ActsAsGraphObject::VERSION
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'roomba/version'

Gem::Specification.new do |spec|
  spec.name          = "roomba-bot"
  spec.version       = Roomba::VERSION
  spec.authors       = ["Kenichi Takemura"]
  spec.email         = ["kenichi_takemura1976@yahoo.com"]
  spec.description   = %q{A bot named roomba-bot}
  spec.summary       = %q{It does not clean your room just walk!}
  spec.homepage      = "http://ktitengineering.com"
  spec.license       = "LGPL"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_development_dependency "rake"
end

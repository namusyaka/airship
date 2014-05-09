# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'airship/version'

Gem::Specification.new do |spec|
  spec.name          = "airship"
  spec.version       = Airship::VERSION
  spec.authors       = ["namusyaka"]
  spec.email         = ["namusyaka@gmail.com"]
  spec.summary       = %q{Airship is the Sinatra/Padrino extension.}
  spec.description   = spec.description
  spec.homepage      = "http://github.com/namusyaka/airship"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "padrino"
  spec.add_development_dependency "sinatra"
end

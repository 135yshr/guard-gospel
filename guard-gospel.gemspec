# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/gospel/version'

Gem::Specification.new do |spec|
  spec.name          = "guard-gospel"
  spec.version       = Guard::GospelVersion::VERSION
  spec.authors       = ["135yshr"]
  spec.email         = ["isago@praisefirst.co.jp"]
  spec.summary       = %q{Guard gem for Gospel}
  spec.description   = %q{Guard gem for launching go files}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'guard', '~> 2.1'
  spec.add_dependency 'sys-proctable', '>= 0.9'
  spec.add_dependency 'childprocess', '>= 0.3'

  spec.add_development_dependency 'rspec', '>= 2.14', '< 4.0'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby-stackoverflow/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-stackoverflow"
  spec.version       = RubyStackoverflow::VERSION
  spec.authors       = ["Rashmi Yadav"]
  spec.email         = ["rays.rashmi@gmail.com"]
  spec.description   = %q{Ruby library for stackoverflow api}
  spec.summary       = %q{Interface for stackoverflow api}
  spec.homepage      = "https://github.com/raysrashmi/ruby-stackoverflow"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "httparty", "~> 0.13.3"
  spec.add_runtime_dependency  "json"

  spec.add_development_dependency "rspec", "~> 2.1"
  spec.add_development_dependency "webmock", "~> 1.14.0"
  spec.add_development_dependency "vcr","~> 2.7.0"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.1.0"
end

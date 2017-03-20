# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_init/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails-init'
  spec.version       = RailsInit::VERSION
  spec.authors       = ['tasukujp']
  spec.email         = ['tasuku.dev@gmail.com']

  spec.summary       = %q{Create a rails application without installing gem in system ruby.}
  spec.description   = %q{Create a rails application without installing gem in system ruby.}
  spec.homepage      = 'https://github.com/tasukujp/rails-init'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor', '~> 0.19'
  spec.add_runtime_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end

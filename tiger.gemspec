# frozen_string_literal: true

require_relative "lib/tiger/version"

Gem::Specification.new do |spec|
  spec.name          = "tiger"
  spec.version       = Tiger::VERSION
  spec.authors       = ["Marcelo Junior"]
  spec.license       = "MIT"

  spec.summary       = "A simple Rack-compatible web server built with Ruby"
  spec.description   = "Tiger is a lightweight web server built on top of Ruby's TCPServer " \
                       "that integrates with the Rack interface to serve HTTP requests."
  spec.homepage      = "https://github.com/juneira/tiger"

  spec.required_ruby_version = ">= 3.0"

  spec.files = Dir["lib/**/*.rb", "LICENSE", "README.md"]

  spec.require_paths = ["lib"]

  spec.add_dependency "rack", "~> 3.2"
  spec.add_dependency "rackup"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'toauth_connect/version'

Gem::Specification.new do |spec|
  spec.name          = "toauth_connect"
  spec.version       = ToauthConnect::VERSION
  spec.authors       = ["Lucas Ferreira"]
  spec.email         = ["lucas.ferreira@outlook.com"]
  spec.summary       = 'OAuth com Toauth'
  spec.homepage      = "git.seplan.to.gov.br"
  spec.license       = "MIT"

  spec.files         =  `git ls-files`.split("n")
  spec.require_path  = 'lib'

  spec.add_dependency 'rest-client'
end
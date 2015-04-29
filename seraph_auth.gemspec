# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "SERAPH Auth"
  spec.version       = '0.0.0'
  spec.authors       = ["Lucas Ferreira"]
  spec.email         = ["lucas.ferreira@outlook.com"]
  spec.summary       = 'OAuth com SERAPH'
  spec.homepage      = "gitlab.defensoria.to.gov.br"
  spec.license       = "MIT"

  spec.files         = ["lib/seraph_auth.rb"] 

  spec.add_dependency 'rest-client'
end
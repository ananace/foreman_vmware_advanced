# frozen_string_literal: true

require_relative 'foreman_vmware_advanced/version'

Gem::Specification.new do |spec|
  spec.name          = 'foreman_vmware_advanced'
  spec.version       = ForemanVmwareAdvanced::VERSION
  spec.authors       = ['Alexander Olofsson']
  spec.email         = ['alexander.olofsson@liu.se']

  spec.summary       = 'Adds advanced values to the VMWare vmx config'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/ananace/foreman_vmware_advanced'
  spec.license       = 'GPL-3.0'

  spec.files         = Dir['{app,lib}/**/*.{rake,rb}'] + %w[LICENSE.txt Rakefile README.md]

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-minitest'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rails'
end

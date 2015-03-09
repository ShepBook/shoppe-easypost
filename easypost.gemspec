$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'shoppe/easypost/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'shoppe-easypost'
  s.version     = Shoppe::Easypost::VERSION
  s.authors     = ['Jared Koumentis']
  s.email       = ['jared@apogeezenith.com']
  s.homepage    = 'https://github.com/ShepBook/shoppe-easypost'
  s.summary     = 'EasyPost integration for Shoppe backend.'
  s.description = 'EasyPost integration for the Shoppe e-commerce engine.'
  s.license     = 'ODPL-1.0'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'shoppe', '>= 1.0.3', '< 2'
  s.add_dependency 'easypost', '~> 2.1', '>= 2.1.0'
end

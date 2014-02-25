$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'angular_validations_rails/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'angular_validations_rails'
  s.version     = AngularValidationsRails::VERSION
  s.authors     = ['Agustin Viñao']
  s.email       = ['agustinvinao@gmail.com']
  s.homepage    = 'http://agustinvinao.com'
  s.summary     = "User your model's validations to do client side checks with AngularJS framework."
  s.description = 'When you use this gem, you are going to define you validations only in your rails models, and set with model are going to be validated with AngularJS help in client side way.'

  #s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  #s.test_files = Dir['test/**/*']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency 'rails', '~> 4.0.0'
  s.add_dependency "railties",  ">= 3.1.1"

  s.add_development_dependency 'sqlite3'

end

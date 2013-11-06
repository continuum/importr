$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "importr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "importr"
  s.version     = Importr::VERSION
  s.authors     = ["Ernesto Garcia", "Miguel Michelson"]
  s.email       = ["gnapse@gmail.com", "miguelmichelson@gmail.com"]
  s.homepage    = "https://github.com/continuum/importr"
  s.summary     = "Full Stack rails engine for xls import to activerecord."
  s.description = "Full Stack rails engine for xls import to activerecord, with process notification through websockets, and activeadmin integration, works with rails 4.0.+."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.1.rc3"
  s.add_dependency "active_importer"
  s.add_dependency "carrierwave"
  s.add_dependency "haml"
  s.add_dependency "roo"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl"
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency "shoulda-matchers", "~>1.0"#, "~> 3.0"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "capybara"
end

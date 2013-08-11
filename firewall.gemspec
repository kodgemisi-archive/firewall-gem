$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "firewall/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "firewall"
  s.version     = Firewall::VERSION
  s.authors     = ["Destan Sarpkaya"]
  s.email       = ["destan@kodgemisi.com"]
  s.homepage    = "http://github.com/kodgemisi/firewall-gem"
  s.summary     = "TODO: Summary of Firewall."
  s.description = "TODO: Description of Firewall."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
end

# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ariane/version"

Gem::Specification.new do |s|
  s.name        = "ariane"
  s.version     = Ariane::VERSION
  s.authors     = ["Simon COURTOIS"]
  s.email       = ["scourtois@cubyx.fr"]
  s.homepage    = "http://github.com/simonc/ariane"
  s.summary     = "A flexible breadcrumb system for Rails, fully compatible " \
                  "with the Twitter Bootstrap."
  s.description = "Ariane is a flexible breadcrumb system for Rails. It is "  \
                  "fully compatible with the Twitter Bootstrap and can be "   \
                  "adapted to any kind of output."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "actionpack",    ">= 2.3.0"
  s.add_dependency "activesupport", ">= 2.3.0"
  s.add_development_dependency "rspec"
end

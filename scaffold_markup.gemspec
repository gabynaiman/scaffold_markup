# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scaffold_markup/version"

Gem::Specification.new do |s|
  s.name        = "scaffold_markup"
  s.version     = ScaffoldMarkup::VERSION
  s.authors     = ["Gabriel Naiman"]
  s.email       = %w(gabynaiman@gmail.com)
  s.homepage    = 'https://github.com/gabynaiman/scaffold_markup'
  s.summary     = 'Rails admin scaffolding'
  s.description = 'Rails admin scaffolding'

  s.rubyforge_project = "scaffold_markup"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end

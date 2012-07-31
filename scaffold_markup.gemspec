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

  s.add_dependency 'twitter_bootstrap_markup', '0.0.3'
  s.add_dependency 'kaminari'
  s.add_dependency 'haml-rails'
  s.add_dependency 'activesupport', ['>= 3.0.0']
  s.add_dependency 'actionpack', ['>= 3.0.0']
end

# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "trusty-snippets-extension"

Gem::Specification.new do |s|
  s.name        = "trusty-snippets-extension"
  s.version     = TrustySnippetsExtension::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = TrustySnippetsExtension::AUTHORS
  s.email       = TrustySnippetsExtension::EMAIL
  s.homepage    = TrustySnippetsExtension::URL
  s.summary     = TrustySnippetsExtension::SUMMARY
  s.description = TrustySnippetsExtension::DESCRIPTION

  ignores = if File.exist?('.gitignore')
    File.read('.gitignore').split("\n").inject([]) {|a,p| a + Dir[p] }
  else
    []
  end
  s.files         = Dir['**/*'] - ignores
  s.test_files    = Dir['test/**/*','spec/**/*','features/**/*'] - ignores
  # s.executables   = Dir['bin/*'] - ignores
  s.require_paths = ["lib"]
end

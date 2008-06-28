require 'rubygems'

spec = Gem::Specification.new do |s|
  s.name        = 'trapeze'
  s.version     = '0.1.17'
  s.author      = 'Nils Jonsson'
  s.email       = 'nils@alumni.rice.edu'
  s.homepage    = 'http://trapeze.rubyforge.org/'
  s.summary     = 'Generates a suite of unit tests or specifications for '     +
                  'existing Ruby source code.'
  s.description = 'This RubyGem generates a suite of unit tests or '           +
                  'specifications for existing Ruby source code.'              +
                  "\n\n"                                                       +
                  'Trapeze does this through dynamic analysis, by reflecting ' +
                  'on the public interfaces of classes and modules (as well '  +
                  'as top-level methods) defined in the source. Trapeze then ' +
                  'calls each public method, stubbing the behavior of '        +
                  'arguments, and recording all the stubbed behavior for use ' +
                  'in generating mock objects. This recorded behavior is '     +
                  'used to generate a test/specification suite that can be '   +
                  'rendered as Test::Unit test cases or other TDD/BDD '        +
                  'libraries.'                                                 +
                  "\n\n"                                                       +
                  'There is a suite renderer for Test::Unit. RSpec and Jay '   +
                  "Fields's Expectations may be supported at some point."
  
  s.files = Dir.glob('{bin,lib,test}/**/*') + %w(Rakefile MIT-LICENSE README)
  
  s.requirements << 'Mocha v0.5.6 or later'
  s.add_dependency 'mocha', '~> 0.5.6'
  s.has_rdoc          = true
  s.extra_rdoc_files  = %w(MIT-LICENSE README bin/trp)
  s.rubyforge_project = 'trapeze'
  s.executables       = %w(trp)
  s.rdoc_options      = %w(--title Trapeze
                           --main README
                           --line-numbers
                           --inline-source)
end

# This file was automatically generated by Trapeze
# (http://trapeze.rubyforge.org/), the safety-net generator for Ruby.

Dir.glob("#{File.dirname __FILE__}/../input/**/*.rb") do |source_file|
  require File.expand_path(source_file)
end

Dir.glob("#{File.dirname __FILE__}/**/*_test.rb") do |test_file|
  require File.expand_path(test_file)
end
require File.expand_path("#{File.dirname __FILE__}/../suite_generators")
require File.expand_path("#{File.dirname __FILE__}/../name_extension")
require File.expand_path("#{File.dirname __FILE__}/../truncate_extension")

# Generates Ruby source files containing Test::Unit test cases.
class Trapeze::SuiteGenerators::TestUnit
  
  # The directory in which generated source files will be created.
  attr_reader :path
  
  def initialize(path)
    unless File.directory?(path)
      raise ArgumentError, 'path must be a directory'
    end
    @path = path
  end
  
  # Deletes the subdirectories and files in path and generates Ruby source files
  # containing a suite a test cases described by _cases_.
  def generate!(cases)
    Dir.truncate path
    
    cases.each do |kase|
      type, method = (kase[:class] || kase[:module]), kase[:method]
#      if type
#        File.open("#{path}/#{type.name.gsub '::', '_'}_test.rb", 'a') do |f|
#          f.puts type.name
#        end
#      else
        File.open("#{path}/#{method.name}_test.rb", 'a') do |f|
          f.print <<-end_print
require 'test/unit'
require 'rubygems'
require 'mocha'

class BarTest < Test::Unit::TestCase
  
  def test_bar
    assert_nil Object.bar
  end
  
end
          end_print
        end
#      end
    end
    
    self
  end
  
end

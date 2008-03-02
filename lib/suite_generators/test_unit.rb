require File.expand_path("#{File.dirname __FILE__}/../suite_generators")
require File.expand_path("#{File.dirname __FILE__}/../empty_dir_extension")
require File.expand_path("#{File.dirname __FILE__}/../name_extension")

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
    Dir.empty_dir! path
    
    cases.each do |kase|
      type, method = (kase[:class] || kase[:module]), kase[:method]
#      if type
#        File.open("#{path}/#{type.name.gsub '::', '_'}_test.rb", 'a') do |f|
#          f.puts type.name
#        end
#      else
        File.open("#{path}/#{method.name}_test.rb", 'a') do |f|
          f.puts "require 'test/unit'"
          f.puts "require 'rubygems'"
          f.puts "require 'mocha'"
          f.puts ''
          f.puts 'class BarTest < Test::Unit::TestCase'
          f.puts '  '
          f.puts '  def test_truth'
          f.puts '    assert true'
          f.puts '  end'
          f.puts '  '
          f.puts 'end'
        end
#      end
    end
    
    self
  end
  
end

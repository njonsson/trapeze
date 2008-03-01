require File.expand_path("#{File.dirname __FILE__}/../suite_generators")
require File.expand_path("#{File.dirname __FILE__}/../empty_dir_extension")

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
    self
  end
  
end

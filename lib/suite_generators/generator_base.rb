# Defines Trapeze::SuiteGenerators::GeneratorBase.

require File.expand_path("#{File.dirname __FILE__}/../suite_generators")
require File.expand_path("#{File.dirname __FILE__}/../truncate_extension")

# The base class for library-specific generators in Trapeze::SuiteGenerators.
class Trapeze::SuiteGenerators::GeneratorBase
  
  class << self
    
    def allocate #:nodoc:
      raise_unless_inherited
      super
    end
    
  private
    
    def raise_unless_inherited
      if self == Trapeze::SuiteGenerators::GeneratorBase
        raise RuntimeError, "#{self} is an abstract class"
      end
    end
    
  end
  
  # The directory in which generated source files will be created.
  attr_reader :path
  
  def initialize(path)
    self.class.send :raise_unless_inherited
    if ! File.directory?(path) && File.exist?(path)
      raise ArgumentError, 'path must be a directory'
    end
    @path = path
  end
  
  # Deletes the subdirectories and files in path and generates Ruby source files
  # containing a suite a test cases described by _cases_.
  def generate!(cases)
    if File.directory?(path)
      Dir.truncate path
    else
      Dir.mkdir path
    end
    
    generate_suite_file!
    
    cases.each do |kase|
      if kase.respond_to?(:class_or_module)
        generate_class_file! kase
      else
        generate_methods_file!
      end
    end
    
    self
  end
  
private
  
  def file_boilerplate
    <<-end_of_string
# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.
    end_of_string
  end
  
end
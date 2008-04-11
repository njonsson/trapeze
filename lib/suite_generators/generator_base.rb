# Defines Trapeze::SuiteGenerators::GeneratorBase.

require 'fileutils'
require File.expand_path("#{File.dirname __FILE__}/../suite_generators")

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
      self
    end
    
  end
  
  # The directory in which generated files will be created.
  attr_reader :path
  
  # The Trapeze::Probe object from which a suite will be generated.
  attr_reader :probe
  
  # (Not to be called directly because Trapeze::SuiteGenerators::GeneratorBase
  # is an abstract class.)
  def initialize(attributes={})
    self.class.send :raise_unless_inherited
    raise_unless_path attributes
    raise_if_path_is_a_file attributes
    raise_unless_probe attributes
    
    @path, @probe = attributes[:path], attributes[:probe]
  end
  
  # Deletes the subdirectories and files in path and generates a suite of test
  # cases or specifications described by _probe_.
  def generate!
    File.directory?(path) ? FileUtils.rm_rf(path) : Dir.mkdir(path)
    
    generate_suite_file!
    generate_class_file!
    generate_module_file!
    generate_methods_file!
    
    self
  end
  
private
  
  def file_boilerplate
    <<-end_of_string
# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.
    end_of_string
  end
  
  def raise_if_path_is_a_file(attributes)
    if File.file?(attributes[:path])
      raise(ArgumentError, ':path attribute must not be a file')
    end
    self
  end
  
  def raise_unless_path(attributes)
    raise(ArgumentError, ':path attribute required') unless attributes[:path]
    self
  end
  
  def raise_unless_probe(attributes)
    raise(ArgumentError, ':probe attribute required') unless attributes[:probe]
    self
  end
  
end

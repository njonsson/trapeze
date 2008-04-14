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
  
  # The Dir.glob pattern used to find source files being analyzed.
  attr_reader :input_files_pattern
  
  # The directory in which generated files will be created.
  attr_reader :output_dir
  
  # The Trapeze::Probe object from which a suite will be generated.
  attr_reader :probe
  
  # (Not to be called directly because Trapeze::SuiteGenerators::GeneratorBase
  # is an abstract class.)
  def initialize(attributes={})
    self.class.send :raise_unless_inherited
    raise_unless_input_files_pattern attributes
    raise_unless_output_dir attributes
    raise_if_output_dir_is_a_file attributes
    raise_unless_probe attributes
    
    attributes.each do |attr, value|
      instance_variable_set "@#{attr}", value
    end
  end
  
  # Clobbers _output_dir_ and generates a suite of test cases or specifications
  # described by _probe_ for the source files of _input_files_pattern_.
  def generate!
    FileUtils.rm_rf(output_dir) if File.exist?(output_dir)
    FileUtils.mkdir_p output_dir
    
    generate_suite_file!
    generate_class_file!
    generate_module_file!
    generate_methods_file!
    
    self
  end
  
private
  
  def dirs_for_path(path)
    path.split /[\\\/]+/
  end
  
  def file_boilerplate
    <<-end_of_string
# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.
    end_of_string
  end
  
  def generate_suite_file!
    File.open("#{output_dir}/SUITE.rb", 'w') do |f|
      f.print <<-end_print
#{file_boilerplate}
Dir.glob(File.expand_path("\#{File.dirname __FILE__}/#{relative_path_to_input_files_pattern}")) do |source_file|
  require File.expand_path(source_file)
end

Dir.glob(File.expand_path("\#{File.dirname __FILE__}/#{generated_files_pattern}")) do |test_file|
  require File.expand_path(test_file)
end
      end_print
    end
    self
  end
  
  def raise_if_output_dir_is_a_file(attributes)
    if File.file?(attributes[:output_dir])
      raise ArgumentError, ':output_dir attribute must not be a file'
    end
    self
  end
  
  %w(input_files_pattern output_dir probe).each do |attribute_name|
    define_method "raise_unless_#{attribute_name}" do |attributes|
      unless attributes[attribute_name.to_sym]
        raise ArgumentError, ":#{attribute_name} attribute required"
      end
      self
    end
  end
  
  def relative_path_to_input_files_pattern
    input_dirs  = dirs_for_path(input_files_pattern)
    output_dirs = dirs_for_path(output_dir)
    min = [input_dirs.length, output_dirs.length].min
    first_different_dir_index = (0..min).detect do |i|
      input_dirs[0..i] != output_dirs[0..i]
    end
    common_dirs = input_dirs[first_different_dir_index..-1]
    up_dirs = ['..'] * (output_dirs.length - first_different_dir_index)
    (up_dirs + common_dirs).join '/'
  end
  
end

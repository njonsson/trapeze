# Defines Trapeze::SuiteGenerators::TestUnit.

require File.expand_path("#{File.dirname __FILE__}/../suite_generators")
require File.expand_path("#{File.dirname __FILE__}/../suite_generators/generator_base")
require File.expand_path("#{File.dirname __FILE__}/../name_extension")
require File.expand_path("#{File.dirname __FILE__}/../to_file_path_extension")

# Generates Ruby source files containing Test::Unit test cases.
class Trapeze::SuiteGenerators::TestUnit <
      Trapeze::SuiteGenerators::GeneratorBase
  
  # Instantiates a new Trapeze::SuiteGenerators::TestUnit from the specified
  # _attributes_. Attributes +:path+ and +:probe+ are required, and +:path+ must
  # not point to an existing file.
  def initialize(attributes={})
    super attributes
  end
  
private
  
  def generate_class_file!
    probe.class_probe_results.each do |r|
      file_path = "#{path}/#{r[:class].to_file_path.gsub /\.rb$/, '_test.rb'}"
      class_name = "#{r[:class].name.split('::').last}Test"
      generate_test_file!(:file_path => file_path,
                          :class_name => class_name) do |f|
        f.puts r[:class].name
      end
    end
    self
  end
  
  def generate_methods_file!
    return self if probe.method_probe_results.empty?
    
    generate_test_file!(:file_path => "#{path}/_test.rb",
                        :class_name => "Test_") do |f|
      probe.method_probe_results.each do |r|
        f.print <<-end_print
  def test_#{r.method_name}_returns_nil
    assert_nil #{r.method_name}
  end
  
        end_print
      end
    end
    self
  end
  
  def generate_module_file!
    probe.module_probe_results.each do |r|
      file_path = "#{path}/#{r[:module].to_file_path.gsub /\.rb$/, '_test.rb'}"
      class_name = "#{r[:module].name.split('::').last}Test"
      generate_test_file!(:file_path => file_path,
                          :class_name => class_name) do |f|
        f.puts r[:module].name
      end
    end
    self
  end
  
  def generate_suite_file!
    File.open("#{path}/SUITE.rb", 'w') do |f|
      f.print <<-end_print
#{file_boilerplate}
Dir.glob(File.expand_path("\#{File.dirname __FILE__}/../input/**/*.rb")) do |source_file|
  require File.expand_path(source_file)
end

Dir.glob(File.expand_path("\#{File.dirname __FILE__}/**/*_test.rb")) do |test_file|
  require File.expand_path(test_file)
end
      end_print
    end
    self
  end
  
  def generate_test_file!(options={})
    File.open(options[:file_path], 'w') do |f|
      f.print <<-end_print
#{file_boilerplate}
require 'test/unit'

class #{options[:class_name]} < Test::Unit::TestCase
  
      end_print
      
      yield f
      
      f.print <<-end_print
end
      end_print
    end
    self
  end
  
end

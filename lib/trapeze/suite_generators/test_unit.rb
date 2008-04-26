# Defines Trapeze::SuiteGenerators::TestUnit.

require File.expand_path("#{File.dirname __FILE__}/../suite_generators")
require File.expand_path("#{File.dirname __FILE__}/../suite_generators/generator_base")
require File.expand_path("#{File.dirname __FILE__}/../describe_extension")
require File.expand_path("#{File.dirname __FILE__}/../inflections_extension")
require File.expand_path("#{File.dirname __FILE__}/../name_extension")

# Generates Test::Unit test cases.
class Trapeze::SuiteGenerators::TestUnit <
      Trapeze::SuiteGenerators::GeneratorBase
  
  # Instantiates a new Trapeze::SuiteGenerators::TestUnit from the specified
  # _attributes_. Attributes <tt>:input_files_pattern</tt>,
  # <tt>:output_dir</tt> and <tt>:probe</tt> are required, and
  # <tt>:output_dir</tt> must not point to an existing file.
  def initialize(attributes={})
    super attributes
  end
  
private
  
  def equality_assertion(expected_value, actual_expr)
    case expected_value
      when NilClass
        "assert_nil #{actual_expr}"
      when Regexp
        "assert_match #{expected_value.inspect}, #{actual_expr}"
      else
        "assert_equal #{expected_value.inspect}, #{actual_expr}"
    end
  end
  
  def generate_class_file!
    probe.class_probe_results.each do |r|
      klass = r[:class]
      class_name = type_name_for_type(klass)
      file_path = "#{output_dir}/#{class_name._pathify}_test.rb"
      test_class_name = "#{klass.name.split('::').last}Test"
      generate_test_file!(:file_path => file_path,
                          :class_name => test_class_name) do |f|
        instance_var_name = "@#{class_name._variablize}"
        if (instantiation = r[:instantiation])
          generate_test!(:file => f, :method_name => 'setup') do |f|
            f.puts "    #{instance_var_name} = #{class_name}.#{instantiation.method_name}"
          end
        end
        generate_test!(:file => f, :method_name => 'test_is_class') do |f|
          f.puts "    assert_instance_of Class, #{class_name}"
        end
        generate_equality_tests! :file => f,
                                 :instance_var_name => instance_var_name,
                                 :method_probings => r[:instance_method_probings]
      end
    end
    self
  end
  
  def generate_equality_tests!(options={})
    file              = options[:file]
    instance_var_name = options[:instance_var_name]
    method_probings   = options[:method_probings]
    method_probings.each do |m|
      method_name, returned = m.method_name, m.reply[:returned]
      value_as_var_name = returned._describe._variablize
      test_method_name = "test_#{method_name}_returns_#{value_as_var_name.gsub /^_/, ''}"
      generate_test!(:file => file, :method_name => test_method_name) do |f|
        assertion = equality_assertion(returned,
                                       "#{instance_var_name}.#{method_name}")
        f.puts "    #{assertion}"
      end
    end
    self
  end
  
  def generate_methods_file!
    return self if probe.method_probe_results.empty?
    
    generate_test_file!(:file_path => "#{output_dir}/_test.rb",
                        :class_name => "Test_") do |f|
      probe.method_probe_results.each do |r|
        generate_test!(:file => f,
                       :method_name => "test_#{r.method_name}_returns_nil") do |f|
          assertion = equality_assertion(r.reply[:returned], r.method_name)
          f.puts "    #{assertion}"
        end
      end
    end
    self
  end
  
  def generate_module_file!
    probe.module_probe_results.each do |r|
      mod = r[:module]
      module_name = type_name_for_type(mod)
      file_path = "#{output_dir}/#{module_name._pathify}_test.rb"
      test_class_name = "#{mod.name.split('::').last}Test"
      generate_test_file!(:file_path => file_path,
                          :class_name => test_class_name) do |f|
        instance_var_name = "@#{module_name._variablize}"
        unless r[:instance_method_probings].empty?
          generate_test!(:file => f, :method_name => 'setup') do |f|
            f.puts "    #{instance_var_name} = Object.new"
            f.puts "    #{instance_var_name}.extend #{module_name}"
          end
        end
        generate_test!(:file => f, :method_name => "test_is_module") do |f|
          f.puts "    assert_instance_of Module, #{module_name}"
        end
        generate_equality_tests! :file => f,
                                 :instance_var_name => instance_var_name,
                                 :method_probings => r[:instance_method_probings]
      end
    end
    self
  end
  
  def generate_test!(options={})
    file = options[:file]
    file.puts "  def #{options[:method_name]}"
    yield file
    file.print <<-end_print
  end
  
    end_print
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
      
      f.puts 'end'
    end
    self
  end
  
  def generated_files_pattern
    '**/*_test.rb'
  end
  
  def type_name_for_type(type)
    type.name.gsub /^.+?::/, ''
  end
  
end

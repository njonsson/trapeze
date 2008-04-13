# Defines Trapeze::SuiteGenerators::TestUnit.

require File.expand_path("#{File.dirname __FILE__}/../suite_generators")
require File.expand_path("#{File.dirname __FILE__}/../suite_generators/generator_base")
require File.expand_path("#{File.dirname __FILE__}/../inflections_extension")
require File.expand_path("#{File.dirname __FILE__}/../name_extension")

# Generates Test::Unit test cases.
class Trapeze::SuiteGenerators::TestUnit <
      Trapeze::SuiteGenerators::GeneratorBase
  
  # Instantiates a new Trapeze::SuiteGenerators::TestUnit from the specified
  # _attributes_. Attributes <tt>:path</tt> and <tt>:probe</tt> are required,
  # and <tt>:path</tt> must not point to an existing file.
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
        "assert_equal #{actual_expr}"
    end
  end
  
  def generate_class_file!
    probe.class_probe_results.each do |r|
      klass = r[:class]
      class_name = type_name_for_type(klass)
      file_path = "#{path}/#{class_name.pathify}_test.rb"
      test_class_name = "#{klass.name.split('::').last}Test"
      generate_test_file!(:file_path => file_path,
                          :class_name => test_class_name) do |f|
        instance_var_name = "@#{class_name.variablize}"
        if (instantiation = r[:instantiation])
          generate_test!(:file => f, :method_name => 'setup') do |f|
            f.puts "    #{instance_var_name} = #{class_name}.#{instantiation.method_name}"
          end
        end
        generate_test!(:file => f, :method_name => 'test_is_class') do |f|
          f.puts "    assert_instance_of Class, #{class_name}"
        end
        r[:instance_method_probings].each do |m|
          method_name, returned = m.method_name, m.reply[:returned]
          test_method_name = "test_#{method_name}_returns_#{returned.inspect}"
          generate_test!(:file => f, :method_name => test_method_name) do |f|
            assertion = equality_assertion(returned,
                                           "#{instance_var_name}.#{method_name}")
            f.puts "    #{assertion}"
          end
        end
      end
    end
    self
  end
  
  def generate_methods_file!
    return self if probe.method_probe_results.empty?
    
    generate_test_file!(:file_path => "#{path}/_test.rb",
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
      file_path = "#{path}/#{module_name.pathify}_test.rb"
      test_class_name = "#{mod.name.split('::').last}Test"
      generate_test_file!(:file_path => file_path,
                          :class_name => test_class_name) do |f|
        instance_var_name = "@#{module_name.variablize}"
        unless r[:instance_method_probings].empty?
          generate_test!(:file => f, :method_name => 'setup') do |f|
            f.puts "    #{instance_var_name} = Object.new"
            f.puts "    #{instance_var_name}.extend #{module_name}"
          end
        end
        generate_test!(:file => f, :method_name => "test_is_module") do |f|
          f.puts "    assert_instance_of Module, #{module_name}"
        end
        r[:instance_method_probings].each do |m|
          method_name, returned = m.method_name, m.reply[:returned]
          test_method_name = "test_#{method_name}_returns_#{returned.inspect}"
          generate_test!(:file => f, :method_name => test_method_name) do |f|
            assertion = equality_assertion(returned,
                                           "#{instance_var_name}.#{method_name}")
            f.puts "    #{assertion}"
          end
        end
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
  
  def type_name_for_type(type)
    type.name.gsub /^.+?::/, ''
  end
  
end

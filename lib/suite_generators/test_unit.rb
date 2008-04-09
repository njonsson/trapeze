# Defines Trapeze::SuiteGenerators::TestUnit.

require File.expand_path("#{File.dirname __FILE__}/../suite_generators")
require File.expand_path("#{File.dirname __FILE__}/../suite_generators/generator_base")
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
  
  def file_path_for_type(type)
    path = type_name_for_type(type)
    path = path.gsub('::',                  '/').
                gsub(/([a-z0-9])([A-Z])/,   '\1_\2').
                gsub(/([A-Z])([A-Z][a-z])/, '\1_\2')
    "#{path.downcase}.rb"
  end
  
  def generate_class_file!
    probe.class_probe_results.each do |r|
      klass = r[:class]
      file_path = "#{path}/#{file_path_for_type(klass).gsub /\.rb$/, '_test.rb'}"
      test_class_name = "#{klass.name.split('::').last}Test"
      generate_test_file!(:file_path => file_path,
                          :class_name => test_class_name) do |f|
        if (instantiation = r[:instantiation])
          generate_test!(:file => f, :method_name => 'setup') do |f|
            f.puts "    @obj = #{type_name_for_type klass}.#{instantiation.method_name}"
          end
        end
        generate_test!(:file => f, :method_name => 'test_is_class') do |f|
          f.puts "    assert_instance_of Class, #{type_name_for_type klass}"
        end
        r[:instance_method_probings].each do |m|
          method_name, returned = m.method_name, m.reply[:returned]
          test_method_name = "test_#{method_name}_returns_#{returned.inspect}"
          generate_test!(:file => f, :method_name => test_method_name) do |f|
            f.puts "    assert_equal #{returned.inspect}, @obj.#{method_name}"
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
          f.puts "    assert_nil #{r.method_name}"
        end
      end
    end
    self
  end
  
  def generate_module_file!
    probe.module_probe_results.each do |r|
      mod = r[:module]
      file_path = "#{path}/#{file_path_for_type(mod).gsub /\.rb$/, '_test.rb'}"
      test_class_name = "#{mod.name.split('::').last}Test"
      generate_test_file!(:file_path => file_path,
                          :class_name => test_class_name) do |f|
        generate_test!(:file => f, :method_name => "test_is_module") do |f|
          f.puts "    assert_instance_of Module, #{type_name_for_type mod}"
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
    type.name.split('::')[1..-1].join '::'
  end
  
end

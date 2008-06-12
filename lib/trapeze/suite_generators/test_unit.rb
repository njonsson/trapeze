# Defines Trapeze::SuiteGenerators::TestUnit.

require File.expand_path("#{File.dirname __FILE__}/../suite_generators")
require File.expand_path("#{File.dirname __FILE__}/../suite_generators/base")
require File.expand_path("#{File.dirname __FILE__}/../describe_extension")
require File.expand_path("#{File.dirname __FILE__}/../inflections_extension")
require File.expand_path("#{File.dirname __FILE__}/../name_extension")

# Generates Test::Unit test cases.
class Trapeze::SuiteGenerators::TestUnit < Trapeze::SuiteGenerators::Base
  
  # Instantiates a new Trapeze::SuiteGenerators::TestUnit from the specified
  # _attributes_. Attributes <tt>:input_files_pattern</tt>,
  # <tt>:output_dir</tt> and <tt>:probe</tt> are required, and
  # <tt>:output_dir</tt> must not point to an existing file.
  def initialize(attributes={})
    super attributes
  end
  
private
  
  def equality_assertion(expected_value, actual_expr)
    return "assert_nil #{actual_expr}" if expected_value.nil?
    return nil unless (literal_value = literal_for(expected_value))
    assertion = 'assert_equal'
    if literal_value.kind_of?(Regexp)
      literal_value = literal_value.inspect
      assertion = 'assert_match'
    end
    args = "#{literal_value}, #{actual_expr}"
    if args[0..0] == '{'
      args = "(#{args})"
    else
      args = " #{args}"
    end
    "#{assertion}#{args}"
  end
  
  def generated_files_pattern
    '**/*_test.rb'
  end
  
  def literal_for(value)
    return nil unless (literal = LITERALS[value.class.to_s])
    literal.call value
  end
  
  def target_for(template, options={})
    case template
      when 'class'
        "#{options[:class_name]._pathify}_test"
      when 'module'
        "#{options[:module_name]._pathify}_test"
      when 'top_level_methods'
        '_test'
      else
        raise ArgumentError, "unexpected template #{template.inspect}"
    end
  end
  
end

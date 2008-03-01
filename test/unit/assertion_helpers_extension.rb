require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/name_extension")
require File.expand_path("#{File.dirname __FILE__}/../../lib/string_comparison_extension")
require 'test/unit'

# Adds additional assertions to Test::Unit::TestCase.
module Trapeze::AssertionHelpersExtension
  
  def assert_classes(expected_descriptions, actual_definitions, message=nil)
    assert_types expected_descriptions, actual_definitions, :class, message
  end
  
  def assert_envelope(expected, actual, message=nil)
    actual = envelope_to_hashes(actual)
    (expected + actual).each do |m|
      if (block = m[:block])
        m[:block] = block.call
      end
    end
    with_clean_backtrace { assert_equal expected, actual, message }
  end
  
  def assert_method(expected_description, actual_definition, message=nil)
    actual_description = method_description(actual_definition)
    with_clean_backtrace do
      assert_equal expected_description, actual_description, message
    end
  end
  
  def assert_methods(expected_descriptions, actual_definitions, message=nil)
    actual_descriptions = actual_definitions.collect do |m|
      method_description m
    end
    with_clean_backtrace do
      assert_equal sort_method_definitions(expected_descriptions),
                   sort_method_definitions(actual_descriptions),
                   message
    end
  end
  
  def assert_modules(expected_descriptions, actual_definitions, message=nil)
    assert_types expected_descriptions, actual_definitions, :module, message
  end
  
  def assert_probe(expected, actual, message=nil)
    with_clean_backtrace do
      assert_equal expected.sort(&probe_results_sorter),
                   actual.sort(&probe_results_sorter),
                   message
    end
  end
  
private
  
  def assert_types(expected_descriptions,
                   actual_definitions,
                   class_or_module,
                   message=nil)
    expected_descriptions = expected_descriptions.inject({}) do |result,
                                                                 key_and_value|
      key, value = key_and_value
      value[:type] = class_or_module
      if value.include?(:class_methods)
        sort_method_definitions! value[:class_methods]
      end
      if value.include?(:instance_methods)
        sort_method_definitions! value[:instance_methods]
      end
      result[key] = value
      result
    end
    actual_descriptions = actual_definitions.inject({}) do |result, t|
      type_name = t.name.gsub(/^.+?::/, '')
      type_definition = {:type => class_or_module}
      unless (class_methods = t.methods(false)).empty?
        type_definition[:class_methods] = class_methods.collect do |m|
          method_description m.to_method(t)
        end
        sort_method_definitions! type_definition[:class_methods]
      end
      unless (instance_methods = t.instance_methods(false)).empty?
        type_definition[:instance_methods] = instance_methods.collect do |m|
          method_description m.to_instance_method(t)
        end
        sort_method_definitions! type_definition[:instance_methods]
      end
      result[type_name] = type_definition
      result
    end
    with_clean_backtrace do
      assert_equal expected_descriptions, actual_descriptions, message
    end
  end
  
  def envelope_to_hashes(envelope)
    envelope.collect do |m|
      args = m.args.collect { |a| envelope_to_hashes(a) rescue a }
      hash = {:method_name => m.method_name,
              :args => args,
              :returned => m.returned}
      hash.merge!(:block => m.block) if m.block
      hash
    end
  end
  
  def method_definitions_sorter
    lambda { |a, b| a.first <=> b.first }
  end
  
  def method_description(method)
    [method.name, {:arity => method.arity}]
  end
  
  def probe_results_sorter
    lambda do |a, b|
      [(a[:class] || a[:module] || ''),
       (a[:class_method] || a[:instance_method] || a[:method] || '')].join <=>
      [(b[:class] || b[:module] || ''),
       (b[:class_method] || b[:instance_method] || b[:method] || '')].join
    end
  end
  
  def sort_method_definitions(method_definitions)
    method_definitions.sort(&method_definitions_sorter)
  end
  
  def sort_method_definitions!(method_definitions)
    method_definitions.sort!(&method_definitions_sorter)
  end
  
  def with_clean_backtrace
    yield
  rescue Test::Unit::AssertionFailedError => e         
    path = File.expand_path(__FILE__)
    backtrace = e.backtrace.reject do |frame|
      File.expand_path(frame) =~ /#{path}/
    end
    raise Test::Unit::AssertionFailedError, e.message, backtrace
  end
  
end

Test::Unit::TestCase.class_eval { include Trapeze::AssertionHelpersExtension }

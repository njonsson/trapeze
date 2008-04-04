# Defines Trapeze::AssertionHelpersExtension.

require File.expand_path("#{File.dirname __FILE__}/test")
require File.expand_path("#{File.dirname __FILE__}/../lib/name_extension")
require File.expand_path("#{File.dirname __FILE__}/../lib/string_comparison_extension")
require File.expand_path("#{File.dirname __FILE__}/../lib/class_or_module_method_probe_result")
require File.expand_path("#{File.dirname __FILE__}/../lib/method_probe_result")
require 'test/unit'

# Adds additional assertions to Test::Unit::TestCase.
module Trapeze::AssertionHelpersExtension
  
  class DirDiff
    
    attr_reader :dir_left, :dir_right
    
    def initialize(attributes={})
      @dir_left, @dir_right = attributes[:dir_left], attributes[:dir_right]
    end
    
    def files_differing
      process! unless @results
      @results[:files_differing]
    end
    
    %w(left right).each do |side|
      define_method "files_unique_to_#{side}" do
        process! unless instance_variable_get('@results')
        instance_variable_get('@results')[:"files_unique_to_#{side}"]
      end
    end
    
    def process!
      @results = {}
      @results[:files_unique_to_left]  = []
      @results[:files_unique_to_right] = []
      @results[:files_differing]       = []
      
      files_left  = Dir.glob("#{dir_left}/**/*")
      files_right = Dir.glob("#{dir_right}/**/*")
      prefix = Regexp.new("^#{Regexp.escape "#{dir_left}/"}")
      files_left_relative = files_left.collect { |f| f.gsub prefix, '' }
      prefix = Regexp.new("^#{Regexp.escape "#{dir_right}/"}")
      files_right_relative = files_right.collect { |f| f.gsub prefix, '' }
      
      [files_left.length, files_right.length].max.times do |i|
        if (index = files_right_relative.index(files_left_relative[i]))
          unless File.read(files_left[i]) == File.read(files_right[index])
            @results[:files_differing] << files_left_relative[i]
          end
        else
          @results[:files_unique_to_left] << files_left_relative[i]
        end
        unless files_left_relative.include?(files_right_relative[i])
          @results[:files_unique_to_right] << files_right_relative[i]
        end
      end
    end
    
  end
  
  def assert_classes(expected_descriptions, actual_definitions, message=nil)
    assert_types expected_descriptions, actual_definitions, :class, message
  end
  
  def assert_dirs_identical(truth_dir, actual_dir)
    diff = DirDiff.new(:dir_left => truth_dir, :dir_right => actual_dir)
    if diff.files_unique_to_left.empty? && diff.files_unique_to_right.empty?
      assert_equal [],
                   diff.files_differing,
                   "#{diff.files_differing.length} file(s) have unexpected content"
    else
      assert_equal [],
                   diff.files_unique_to_left,
                   "#{diff.files_unique_to_left.length} file(s) expected to exist but do not"
      assert_equal [],
                   diff.files_unique_to_right,
                   "#{diff.files_unique_to_right.length} file(s) not expected to exist but do exist"
    end
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
      assert_equal expected_descriptions.sort(&method_definitions_sorter),
                   actual_descriptions.sort(&method_definitions_sorter),
                   message
    end
  end
  
  def assert_modules(expected_descriptions, actual_definitions, message=nil)
    assert_types expected_descriptions, actual_definitions, :module, message
  end
  
  def assert_probe_results(expected_result_descriptions,
                           actual_results,
                           message=nil)
    expected_result_descriptions.each do |r|
      if r.include?(:probings)
        r[:probings].sort! &method_probe_result_descriptions_sorter
      end
    end.sort!(&method_probe_result_descriptions_sorter)
    
    actual_result_descriptions = actual_results.collect do |r|
      probe_result_to_hash r
    end.sort(&method_probe_result_descriptions_sorter)
    
    with_clean_backtrace do
      assert_equal expected_result_descriptions,
                   actual_result_descriptions,
                   message
    end
  end
  
  def assert_raise_message(expected_exception, message)
    unless expected_exception.kind_of?(Class) &&
           expected_exception.ancestors.include?(Exception)
      raise ArgumentError,
            "`expected_exception' must be Exception, or must descend from it"
    end
    
    begin
      yield
    rescue Exception => e
      with_clean_backtrace do
        assert_equal expected_exception, e.class
        if message.kind_of?(Regexp)
          assert_match message, e.message
        else
          assert_equal message, e.message
        end
      end
    else
      with_clean_backtrace do
        flunk "<#{expected_exception}> exception expected but none was raised"
      end
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
        value[:class_methods].sort! &method_definitions_sorter
      end
      if value.include?(:instance_methods)
        value[:instance_methods].sort! &method_definitions_sorter
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
        type_definition[:class_methods].sort! &method_definitions_sorter
      end
      unless (instance_methods = t.instance_methods(false)).empty?
        type_definition[:instance_methods] = instance_methods.collect do |m|
          method_description m.to_instance_method(t)
        end
        type_definition[:instance_methods].sort! &method_definitions_sorter
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
  
  def probe_result_to_hash(probe_result)
    hash = {}
    if probe_result.respond_to?(:probings)
      hash[:probings] = probe_result.probings.collect do |r|
        probe_result_to_hash r
      end.sort(&method_probe_result_descriptions_sorter)
      if probe_result.respond_to?(:instantiation) &&
         (instantiation = probe_result.instantiation)
        if instantiation.kind_of?(Trapeze::ClassOrModuleMethodProbeResult)
          hash[:instantiation] = probe_result_to_hash(instantiation)
        else
          hash[:instantiation] = instantiation
        end
      end
      hash
    else
      hash[:method_name] = probe_result.method_name
      if probe_result.respond_to?(:class_or_module)
        hash[:class_or_module] = probe_result.class_or_module
      end
      hash[:args] = probe_result.args unless probe_result.args.empty?
      hash[:block] = probe_result.block if probe_result.block
      hash.merge! probe_result.result
    end
  end
  
  def method_probe_result_descriptions_sorter
    lambda do |a, b|
      "#{a[:class_or_module]}#{a[:method_name]}" <=>
      "#{b[:class_or_module]}#{b[:method_name]}"
    end
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
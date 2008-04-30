# Defines Trapeze::AssertionHelpersExtension.

require File.expand_path("#{File.dirname __FILE__}/test")
require File.expand_path("#{File.dirname __FILE__}/../lib/trapeze/name_extension")
require File.expand_path("#{File.dirname __FILE__}/../lib/trapeze/sandbox")
require File.expand_path("#{File.dirname __FILE__}/../lib/trapeze/string_comparison_extension")
require File.expand_path("#{File.dirname __FILE__}/../lib/trapeze/to_method_extension")
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
      define_method "files_#{side}" do
        get_result :"files_#{side}"
      end
      define_method "files_unique_to_#{side}" do
        get_result :"files_unique_to_#{side}"
      end
    end
    
    def process!
      @results = {:files_left            => [],
                  :files_right           => [],
                  :files_unique_to_left  => [],
                  :files_unique_to_right => [],
                  :files_differing       => []}
      
      files_left_hash  = dir_to_file_paths_hash(dir_left)
      files_right_hash = dir_to_file_paths_hash(dir_right)
      
      files_common, files_unique_to_left = files_left_hash.keys.partition do |relative|
        files_right_hash.include? relative
      end
      files_differing = files_common.reject do |relative|
        File.read(files_left_hash[relative]) ==
        File.read(files_right_hash[relative])
      end
      
      @results[:files_left]            = files_left_hash.keys
      @results[:files_right]           = files_right_hash.keys
      @results[:files_unique_to_left]  = files_unique_to_left
      @results[:files_unique_to_right] = files_right_hash.keys - files_common
      @results[:files_differing]       = files_differing
    end
    
  private
    
    def dir_to_file_paths_hash(dir)
      file_paths = Dir.glob("#{dir}/**/*")
      prefix = Regexp.new("^#{Regexp.escape "#{dir}/"}")
      file_paths.inject({}) do |result, file_path|
        relative_file_path = file_path.gsub(prefix, '')
        result.merge relative_file_path => file_path
      end
    end
    
    def get_result(result)
      process! unless instance_variable_get('@results')
      instance_variable_get('@results')[result]
    end
    
  end
  
  def assert_classes(expected_descriptions, actuals, message=nil)
    assert_types expected_descriptions, actuals, :class, message
  end
  
  def assert_dirs_identical(truth_dir, actual_dir)
    diff = DirDiff.new(:dir_left => truth_dir, :dir_right => actual_dir)
    if diff.files_left.empty? && diff.files_right.empty?
      raise "both #{truth_dir} and #{actual_dir} are empty!"
    end
    
    if diff.files_unique_to_left.empty? && diff.files_unique_to_right.empty?
      with_clean_backtrace do
        assert_equal [],
                     diff.files_differing,
                     "#{diff.files_differing.length} file(s) in #{actual_dir} have unexpected content"
      end
    else
      with_clean_backtrace do
        assert_equal [],
                     diff.files_unique_to_left,
                     "#{diff.files_unique_to_left.length} file(s) in #{actual_dir} expected to exist but do not"
        assert_equal [],
                     diff.files_unique_to_right,
                     "#{diff.files_unique_to_right.length} file(s) in #{actual_dir} not expected to exist but do exist"
      end
    end
  end
  
  def assert_envelope(expected_description, actual, message=nil)
    actual_description = messages_to_descriptions(actual)
    (expected_description + actual_description).each do |m|
      if (block = m[:block])
        m[:block] = block.call
      end
    end
    with_clean_backtrace do
      assert_equal expected_description, actual_description, message
    end
  end
  
  def assert_method(expected_description, actual, message=nil)
    actual_description = method_description(actual)
    with_clean_backtrace do
      assert_equal expected_description, actual_description, message
    end
  end
  
  def assert_methods(expected_descriptions, actuals, message=nil)
    actual_descriptions = actuals.collect { |m| method_description m }
    with_clean_backtrace do
      assert_equal expected_descriptions, actual_descriptions, message
    end
  end
  
  def assert_modules(expected_descriptions, actuals, message=nil)
    assert_types expected_descriptions, actuals, :module, message
  end
  
  def assert_probe_results(expected, actual, message=nil)
    actual.each do |r|
      if r[:class_method_probings]
        if r[:class_method_probings].empty?
          r.delete :class_method_probings
        else
          r[:class_method_probings].collect! { |m| message_to_description m }
        end
      end
      if r[:module_method_probings]
        if r[:module_method_probings].empty?
          r.delete :module_method_probings
        else
          r[:module_method_probings].collect! { |m| message_to_description m }
        end
      end
      if r[:instantiation]
        instantiation = message_to_description(r[:instantiation])
        instantiation.delete :returned if instantiation.include?(:returned)
        r[:instantiation] = instantiation
      end
      if r[:instance_method_probings]
        if r[:instance_method_probings].empty?
          r.delete :instance_method_probings
        else
          r[:instance_method_probings].collect! { |m| message_to_description m }
        end
      end
    end
    with_clean_backtrace { assert_equal expected, actual, message }
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
  
  def assert_types(expected_descriptions, actuals, class_or_module, message=nil)
    expected_descriptions = expected_descriptions.inject({}) do |result,
                                                                 key_and_value|
      key, value = key_and_value
      value[:type] = class_or_module
      result[key] = value
      result
    end
    actual_descriptions = actuals.inject({}) do |result, t|
      type_name = Trapeze::Sandbox.strip_from_type_name(t)
      type_definition = {:type => class_or_module}
      unless (class_methods = t.methods(false).sort).empty?
        type_definition[:class_methods] = class_methods.collect do |m|
          method_description m._to_method(t)
        end
      end
      unless (instance_methods = t.instance_methods(false).sort).empty?
        type_definition[:instance_methods] = instance_methods.collect do |m|
          method_description m._to_instance_method(t)
        end
      end
      result[type_name] = type_definition
      result
    end
    with_clean_backtrace do
      assert_equal expected_descriptions, actual_descriptions, message
    end
  end
  
  def message_to_description(message)
    hash = message.reply.merge(:method_name => message.method_name)
    args = message.args.collect { |a| messages_to_descriptions(a) rescue a }
    hash.merge!(:args => args) unless args.empty?
    hash.merge!(:block => message.block) if message.block
    hash
  end
  
  def messages_to_descriptions(messages)
    messages.collect { |m| message_to_description m }
  end
  
  def method_description(method)
    [method._name, {:arity => method.arity}]
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

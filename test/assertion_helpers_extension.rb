# Defines Trapeze::AssertionHelpersExtension.

require File.expand_path("#{File.dirname __FILE__}/test")
require File.expand_path("#{File.dirname __FILE__}/../lib/trapeze/name_extension")
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
    actual_descriptions = actuals.inject({}) do |result, type|
      result[type] = {}
      unless type._defined_methods.empty?
        result[type][:class_methods] = type._defined_methods
      end
      unless type._defined_instance_methods.empty?
        result[type][:instance_methods] = type._defined_instance_methods
      end
      result
    end
    with_clean_backtrace do
      assert_equal expected_descriptions, actual_descriptions, message
    end
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
  
  def assert_envelope(expected, actual, message=nil)
    format_messages! actual
    (expected + actual).each do |m|
      if (block = m[:block])
        m[:block] = block.call
      end
    end
    with_clean_backtrace do
      assert_equal expected, actual, message
    end
  end
  
  def assert_method(expected_description, actual, message=nil)
    actual_description = method_description(actual)
    with_clean_backtrace do
      assert_equal expected_description, actual_description, message
    end
  end
  
  def assert_modules(expected_descriptions, actuals, message=nil)
    actual_descriptions = actuals.inject({}) do |result, type|
      result[type] = {}
      unless type._defined_methods.empty?
        result[type][:module_methods] = type._defined_methods
      end
      unless type._defined_instance_methods.empty?
        result[type][:instance_methods] = type._defined_instance_methods
      end
      result
    end
    with_clean_backtrace do
      assert_equal expected_descriptions, actual_descriptions, message
    end
  end
  
  def assert_probe_results(expected, actual, message=nil)
    actual.each do |r|
      if r[:class_method_probings]
        if r[:class_method_probings].empty?
          r.delete :class_method_probings
        else
          r[:class_method_probings].collect! { |m| format_message! m }
        end
      end
      if r[:module_method_probings]
        if r[:module_method_probings].empty?
          r.delete :module_method_probings
        else
          r[:module_method_probings].collect! { |m| format_message! m }
        end
      end
      if r[:instantiation]
        instantiation = format_message!(r[:instantiation])
        instantiation.delete :returned if instantiation.include?(:returned)
        r[:instantiation] = instantiation
      end
      if r[:instance_method_probings]
        if r[:instance_method_probings].empty?
          r.delete :instance_method_probings
        else
          r[:instance_method_probings].collect! { |m| format_message! m }
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
  
  def format_message!(message)
    if message.include?(:args)
      args = message[:args]
      if args.nil? || args.empty?
        message.delete :args
      else
        args.collect! do |a|
          a.instance_of?(Trapeze::Envelope) ? format_messages!(a) : a
        end
      end
    end
    message.delete(:block) if (message.include?(:block) && message[:block].nil?)
    if message[:returned].instance_of?(Trapeze::Envelope)
      format_messages! message[:returned]
    end
    message
  end
  
  def format_messages!(messages)
    messages.collect! { |m| format_message! m }
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

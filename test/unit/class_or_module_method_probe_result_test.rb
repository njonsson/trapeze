require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/class_or_module_method_probe_result")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/assertion_helpers_extension")

module Trapeze::ClassOrModuleMethodProbeResultTest
  
  class Allocate < Test::Unit::TestCase
    
    def test_should_raise_no_method_error
      assert_raise_message(NoMethodError, /private method `allocate' called/) do
        Trapeze::ClassOrModuleMethodProbeResult.allocate
      end
    end
    
  end
  
  class New < Test::Unit::TestCase
    
    def test_should_raise_no_method_error
      assert_raise_message(NoMethodError, /private method `new' called/) do
        Trapeze::ClassOrModuleMethodProbeResult.new
      end
    end
    
  end
  
  module Raised
    
    class WithNoArgs < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':class_or_module attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.raised
        end
      end
      
    end
    
    class WithUnexpectedAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':foo attribute unexpected') do
          Trapeze::ClassOrModuleMethodProbeResult.raised :foo => 'bar'
        end
      end
      
    end
    
    class WithNilClassOrModuleAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':class_or_module attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.raised :class_or_module => nil
        end
      end
      
    end
    
    class WithClassOrModuleAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.raised :class_or_module => Object
        end
      end
      
    end
    
    class WithClassOrModuleAttributeAndNilMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.raised :class_or_module => Object,
                                                         :method_name => nil
        end
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.raised :class_or_module => Object,
                                                         :method_name => 'foo'
        end
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.raised :class_or_module => Object,
                                                         :method_name => 'foo',
                                                         :args => 'bar'
        end
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.raised :class_or_module => Object,
                                                         :method_name => 'foo',
                                                         :block => lambda { Time.now }
        end
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.raised :class_or_module => Object,
                                                         :method_name => 'foo',
                                                         :args => 'bar',
                                                         :block => lambda { Time.now }
        end
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndNilArgsAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => nil,
                                                                              :error => RuntimeError)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_array_containing_nil_when_sent_args
        assert_equal [nil], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:raised => {:error => RuntimeError}},
                     @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndEmptyArgsAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => [],
                                                                              :error => RuntimeError)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:raised => {:error => RuntimeError}},
                     @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => 'bar',
                                                                              :error => RuntimeError)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_array_containing_expected_arg_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:raised => {:error => RuntimeError}},
                     @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArrayArgsAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => ['bar'],
                                                                              :error => RuntimeError)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:raised => {:error => RuntimeError}},
                     @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndNilBlockAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :block => nil,
                                                                              :error => RuntimeError)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:raised => {:error => RuntimeError}},
                     @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndBlockAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :block => lambda { @time },
                                                                              :error => RuntimeError)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @method_probe_result.block.call
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:raised => {:error => RuntimeError}},
                     @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttributeAndBlockAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => ['bar'],
                                                                              :block => lambda { @time },
                                                                              :error => RuntimeError)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @method_probe_result.block.call
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:raised => {:error => RuntimeError}},
                     @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttributeAndBlockAttributeAndErrorAttributeAndErrorMessageAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => ['bar'],
                                                                              :block => lambda { @time },
                                                                              :error => RuntimeError,
                                                                              :error_message => 'baz')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @method_probe_result.block.call
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:raised => {:error => RuntimeError, :message => 'baz'}},
                     @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndNilErrorAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.raised :class_or_module => Object,
                                                         :method_name => 'foo',
                                                         :error => nil
        end
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :error => RuntimeError)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:raised => {:error => RuntimeError}},
                     @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndErrorAttributeAndNilErrorMessageAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :error => RuntimeError,
                                                                              :error_message => nil)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:raised => {:error => RuntimeError}},
                     @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndErrorAttributeAndErrorMessageAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :error => RuntimeError,
                                                                              :error_message => 'bar')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:raised => {:error => RuntimeError,
                                  :message => 'bar'}},
                     @method_probe_result.result)
      end
      
    end
    
  end
  
  module Returned
    
    class WithNoArgs < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':class_or_module attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.returned
        end
      end
      
    end
    
    class WithUnexpectedAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':foo attribute unexpected') do
          Trapeze::ClassOrModuleMethodProbeResult.returned :foo => 'bar'
        end
      end
      
    end
    
    class WithNilClassOrModuleAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':class_or_module attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.returned :class_or_module => nil
        end
      end
      
    end
    
    class WithClassOrModuleAttributeAndNilMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.returned :class_or_module => Object,
                                                           :method_name => nil
        end
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndNilArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :args => nil)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_array_containing_nil_when_sent_args
        assert_equal [nil], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndEmptyArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :args => [])
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :args => 'bar')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_array_containing_expected_arg_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArrayArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :args => ['bar'])
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndNilBlockAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :block => nil)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :block => lambda { @time })
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @method_probe_result.block.call
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :args => 'bar',
                                                                                :block => lambda { @time })
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @method_probe_result.block.call
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndNilArgsAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :args => nil,
                                                                                :returned => 'bar')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_array_containing_nil_when_sent_args
        assert_equal [nil], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => 'bar'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndEmptyArgsAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :args => [],
                                                                                :returned => 'bar')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => 'bar'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :args => 'bar',
                                                                                :returned => 'baz')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_array_containing_expected_arg_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => 'baz'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArrayArgsAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :args => ['bar'],
                                                                                :returned => 'baz')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => 'baz'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndNilBlockAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :block => nil,
                                                                                :returned => 'bar')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => 'bar'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndBlockAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :block => lambda { @time },
                                                                                :returned => 'bar')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @method_probe_result.block.call
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => 'bar'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttributeAndBlockAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :args => ['bar'],
                                                                                :block => lambda { @time },
                                                                                :returned => 'baz')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @method_probe_result.block.call
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => 'baz'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttributeAndBlockAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :args => ['bar'],
                                                                                :block => lambda { @time },
                                                                                :returned => 'baz')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @method_probe_result.block.call
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => 'baz'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndNilReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :returned => nil)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                                                :method_name => 'foo',
                                                                                :returned => 'bar')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:returned => 'bar'}, @method_probe_result.result)
      end
      
    end
    
  end
  
  module Thrown
    
    class WithNoArgs < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':class_or_module attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.thrown
        end
      end
      
    end
    
    class WithUnexpectedAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':foo attribute unexpected') do
          Trapeze::ClassOrModuleMethodProbeResult.thrown :foo => 'bar'
        end
      end
      
    end
    
    class WithNilClassOrModuleAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':class_or_module attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.thrown :class_or_module => nil
        end
      end
      
    end
    
    class WithClassOrModuleAttributeAndNilMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::ClassOrModuleMethodProbeResult.thrown :class_or_module => Object,
                                                         :method_name => nil
        end
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndNilArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => nil)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_array_containing_nil_when_sent_args
        assert_equal [nil], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndEmptyArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => [])
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => 'bar')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_array_containing_expected_arg_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArrayArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => ['bar'])
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndNilBlockAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :block => nil)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :block => lambda { @time })
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @method_probe_result.block.call
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => 'bar',
                                                                              :block => lambda { @time })
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @method_probe_result.block.call
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndNilArgsAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => nil,
                                                                              :thrown => 'bar')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_array_containing_nil_when_sent_args
        assert_equal [nil], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => 'bar'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndEmptyArgsAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => [],
                                                                              :thrown => 'bar')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => 'bar'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => 'bar',
                                                                              :thrown => 'baz')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_array_containing_expected_arg_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => 'baz'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArrayArgsAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => ['bar'],
                                                                              :thrown => 'baz')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => 'baz'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndNilBlockAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :block => nil,
                                                                              :thrown => 'bar')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => 'bar'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndBlockAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :block => lambda { @time },
                                                                              :thrown => 'bar')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @method_probe_result.block.call
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => 'bar'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttributeAndBlockAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => ['bar'],
                                                                              :block => lambda { @time },
                                                                              :thrown => 'baz')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @method_probe_result.block.call
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => 'baz'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndArgsAttributeAndBlockAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :args => ['bar'],
                                                                              :block => lambda { @time },
                                                                              :thrown => 'baz')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @method_probe_result.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @method_probe_result.block.call
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => 'baz'}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndNilReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :thrown => nil)
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => nil}, @method_probe_result.result)
      end
      
    end
    
    class WithClassOrModuleAttributeAndMethodNameAttributeAndReturnedAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                                              :method_name => 'foo',
                                                                              :thrown => 'bar')
      end
      
      def test_should_return_expected_class_when_sent_class_or_module
        assert_equal Object, @method_probe_result.class_or_module
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @method_probe_result.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @method_probe_result.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @method_probe_result.block
      end
      
      def test_should_return_expected_hash_when_sent_result
        assert_equal({:thrown => 'bar'}, @method_probe_result.result)
      end
      
    end
    
  end
  
  module EQUALEQUAL
    
    module WithReturnedObject
      
      class Equivalent < Test::Unit::TestCase
        
        def test_should_return_true
          a = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                               :method_name => 'foo',
                                                               :args => 'bar',
                                                               :block => lambda { 'baz' },
                                                               :returned => 'bat')
          b = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                               :method_name => 'foo',
                                                               :args => 'bar',
                                                               :block => lambda { 'baz' },
                                                               :returned => 'bat')
          assert_equal(true, (a == b))
        end
        
      end
      
      class DifferingByClassOrModule < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                               :method_name => 'foo',
                                                               :args => 'bar',
                                                               :block => lambda { 'baz' },
                                                               :returned => 'bat')
          b = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Class,
                                                               :method_name => 'foo',
                                                               :args => 'bar',
                                                               :block => lambda { 'baz' },
                                                               :returned => 'bat')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByArgs < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                               :method_name => 'foo',
                                                               :args => 'bar',
                                                               :block => lambda { 'bat' },
                                                               :returned => 'pwop')
          b = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                               :method_name => 'foo',
                                                               :args => 'baz',
                                                               :block => lambda { 'bat' },
                                                               :returned => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByValueOfBlock < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                               :method_name => 'foo',
                                                               :args => 'bar',
                                                               :block => lambda { 'baz' },
                                                               :returned => 'pwop')
          b = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                               :method_name => 'foo',
                                                               :args => 'bar',
                                                               :block => lambda { 'bat' },
                                                               :returned => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByResult < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                               :method_name => 'foo',
                                                               :args => 'bar',
                                                               :block => lambda { 'baz' },
                                                               :returned => 'bat')
          b = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => Object,
                                                               :method_name => 'foo',
                                                               :args => 'bar',
                                                               :block => lambda { 'baz' },
                                                               :returned => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
    end
    
    module WithRaisedObject
      
      class Equivalent < Test::Unit::TestCase
        
        def test_should_return_true
          a = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :error => RuntimeError,
                                                             :error_message => 'bat')
          b = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :error => RuntimeError,
                                                             :error_message => 'bat')
          assert_equal(true, (a == b))
        end
        
      end
      
      class DifferingByClassOrModule < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :error => RuntimeError,
                                                             :error_message => 'bat')
          b = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Class,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :error => RuntimeError,
                                                             :error_message => 'bat')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByArgs < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'bat' },
                                                             :error => RuntimeError,
                                                             :error_message => 'pwop')
          b = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'baz',
                                                             :block => lambda { 'bat' },
                                                             :error => RuntimeError,
                                                             :error_message => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByValueOfBlock < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :error => RuntimeError,
                                                             :error_message => 'pwop')
          b = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'bat' },
                                                             :error => RuntimeError,
                                                             :error_message => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByResultError < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :error => RuntimeError,
                                                             :error_message => 'bat')
          b = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :error => Exception,
                                                             :error_message => 'bat')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByResultErrorMessage < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :error => RuntimeError,
                                                             :error_message => 'bat')
          b = Trapeze::ClassOrModuleMethodProbeResult.raised(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :error => RuntimeError,
                                                             :error_message => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
    end
    
    module WithThrownObject
      
      class Equivalent < Test::Unit::TestCase
        
        def test_should_return_true
          a = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :thrown => 'bat')
          b = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :thrown => 'bat')
          assert_equal(true, (a == b))
        end
        
      end
      
      class DifferingByClassOrModule < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :thrown => 'bat')
          b = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Class,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :thrown => 'bat')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByArgs < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'bat' },
                                                             :thrown => 'pwop')
          b = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'baz',
                                                             :block => lambda { 'bat' },
                                                             :thrown => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByValueOfBlock < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :thrown => 'pwop')
          b = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'bat' },
                                                             :thrown => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByResult < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :thrown => 'bat')
          b = Trapeze::ClassOrModuleMethodProbeResult.thrown(:class_or_module => Object,
                                                             :method_name => 'foo',
                                                             :args => 'bar',
                                                             :block => lambda { 'baz' },
                                                             :thrown => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
    end
    
  end
  
end

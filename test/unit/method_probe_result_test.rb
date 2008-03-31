require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/method_probe_result")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/../assertion_helpers_extension")

module Trapeze::MethodProbeResultTest
  
  class Allocate < Test::Unit::TestCase
    
    def test_should_raise_no_method_error
      assert_raise_message(NoMethodError, /private method `allocate' called/) do
        Trapeze::MethodProbeResult.allocate
      end
    end
    
  end
  
  class New < Test::Unit::TestCase
    
    def test_should_raise_no_method_error
      assert_raise_message(NoMethodError, /private method `new' called/) do
        Trapeze::MethodProbeResult.new
      end
    end
    
  end
  
  module Raised
    
    class WithNoArgs < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::MethodProbeResult.raised
        end
      end
      
    end
    
    class WithUnexpectedAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':foo attribute unexpected') do
          Trapeze::MethodProbeResult.raised :foo => 'bar'
        end
      end
      
    end
    
    class WithNilMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::MethodProbeResult.raised :method_name => nil
        end
      end
      
    end
    
    class WithMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::MethodProbeResult.raised :method_name => 'foo'
        end
      end
      
    end
    
    class WithMethodNameAttributeAndArgsAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::MethodProbeResult.raised :method_name => 'foo',
                                            :args => 'bar'
        end
      end
      
    end
    
    class WithMethodNameAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::MethodProbeResult.raised :method_name => 'foo',
                                            :block => lambda { Time.now }
        end
      end
      
    end
    
    class WithMethodNameAttributeAndArgsAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::MethodProbeResult.raised :method_name => 'foo',
                                            :args => 'bar',
                                            :block => lambda { Time.now }
        end
      end
      
    end
    
    class WithMethodNameAttributeAndNilArgsAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                                 :args => nil,
                                                                 :error => RuntimeError)
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
    
    class WithMethodNameAttributeAndEmptyArgsAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                                 :args => [],
                                                                 :error => RuntimeError)
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
    
    class WithMethodNameAttributeAndArgsAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                                 :args => 'bar',
                                                                 :error => RuntimeError)
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
    
    class WithMethodNameAttributeAndArrayArgsAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                                 :args => ['bar'],
                                                                 :error => RuntimeError)
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
    
    class WithMethodNameAttributeAndNilBlockAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                                 :block => nil,
                                                                 :error => RuntimeError)
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
    
    class WithMethodNameAttributeAndBlockAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                                 :block => lambda { @time },
                                                                 :error => RuntimeError)
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
    
    class WithMethodNameAttributeAndArgsAttributeAndBlockAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                                 :args => 'bar',
                                                                 :block => lambda { @time },
                                                                 :error => RuntimeError)
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
    
    class WithMethodNameAttributeAndArgsAttributeAndBlockAttributeAndErrorAttributeAndErrorMessageAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                                 :args => 'bar',
                                                                 :block => lambda { @time },
                                                                 :error => RuntimeError,
                                                                 :error_message => 'baz')
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
    
    class WithMethodNameAttributeAndNilErrorAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::MethodProbeResult.raised :method_name => 'foo', :error => nil
        end
      end
      
    end
    
    class WithMethodNameAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                                 :error => RuntimeError)
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
    
    class WithMethodNameAttributeAndErrorAttributeAndNilErrorMessageAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                                 :error => RuntimeError,
                                                                 :error_message => nil)
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
    
    class WithMethodNameAttributeAndErrorAttributeAndErrorMessageAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                                 :error => RuntimeError,
                                                                 :error_message => 'bar')
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
                             ':method_name attribute required') do
          Trapeze::MethodProbeResult.returned
        end
      end
      
    end
    
    class WithUnexpectedAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':foo attribute unexpected') do
          Trapeze::MethodProbeResult.returned :foo => 'bar'
        end
      end
      
    end
    
    class WithNilMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::MethodProbeResult.returned :method_name => nil
        end
      end
      
    end
    
    class WithMethodNameAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.returned(:method_name => 'foo')
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
    
    class WithMethodNameAttributeAndNilArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                                   :args => nil)
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
    
    class WithMethodNameAttributeAndEmptyArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                                   :args => [])
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
    
    class WithMethodNameAttributeAndArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                                   :args => 'bar')
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
    
    class WithMethodNameAttributeAndArrayArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                                   :args => ['bar'])
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
    
    class WithMethodNameAttributeAndNilBlockAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                                   :block => nil)
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
    
    class WithMethodNameAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                                   :block => lambda { @time })
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
    
    class WithMethodNameAttributeAndArgsAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                                   :args => 'bar',
                                                                   :block => lambda { @time })
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
    
  end
  
  module Thrown
    
    class WithNoArgs < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::MethodProbeResult.thrown
        end
      end
      
    end
    
    class WithUnexpectedAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':foo attribute unexpected') do
          Trapeze::MethodProbeResult.thrown :foo => 'bar'
        end
      end
      
    end
    
    class WithNilMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::MethodProbeResult.thrown :method_name => nil
        end
      end
      
    end
    
    class WithMethodNameAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.thrown(:method_name => 'foo')
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
    
    class WithMethodNameAttributeAndNilArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                                 :args => nil)
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
    
    class WithMethodNameAttributeAndEmptyArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                                 :args => [])
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
    
    class WithMethodNameAttributeAndArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                                 :args => 'bar')
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
    
    class WithMethodNameAttributeAndArrayArgsAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                                 :args => ['bar'])
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
    
    class WithMethodNameAttributeAndNilBlockAttribute < Test::Unit::TestCase
      
      def setup
        @method_probe_result = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                                 :block => nil)
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
    
    class WithMethodNameAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                                 :block => lambda { @time })
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
    
    class WithMethodNameAttributeAndArgsAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @method_probe_result = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                                 :args => 'bar',
                                                                 :block => lambda { @time })
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
    
  end
  
  module EQUALEQUAL
    
    module WithReturnedObject
      
      class Equivalent < Test::Unit::TestCase
        
        def test_should_return_true
          baz = lambda { 'baz' }
          a = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                  :args => 'bar',
                                                  :block => baz,
                                                  :returned => 'bat')
          b = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                  :args => 'bar',
                                                  :block => baz,
                                                  :returned => 'bat')
          assert_equal(true, (a == b))
        end
        
      end
      
      class DifferingByArgs < Test::Unit::TestCase
        
        def test_should_return_false
          bat = lambda { 'bat' }
          a = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                  :args => 'bar',
                                                  :block => bat,
                                                  :returned => 'pwop')
          b = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                  :args => 'baz',
                                                  :block => bat,
                                                  :returned => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByValueOfBlock < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                  :args => 'bar',
                                                  :block => lambda { 'baz' },
                                                  :returned => 'pwop')
          b = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                  :args => 'bar',
                                                  :block => lambda { 'bat' },
                                                  :returned => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByResult < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
                                                  :args => 'bar',
                                                  :block => lambda { 'baz' },
                                                  :returned => 'bat')
          b = Trapeze::MethodProbeResult.returned(:method_name => 'foo',
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
          baz = lambda { 'baz' }
          a = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => baz,
                                                :error => RuntimeError,
                                                :error_message => 'bat')
          b = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => baz,
                                                :error => RuntimeError,
                                                :error_message => 'bat')
          assert_equal(true, (a == b))
        end
        
      end
      
      class DifferingByArgs < Test::Unit::TestCase
        
        def test_should_return_false
          bat = lambda { 'bat' }
          a = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => bat,
                                                :error => RuntimeError,
                                                :error_message => 'pwop')
          b = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                :args => 'baz',
                                                :block => bat,
                                                :error => RuntimeError,
                                                :error_message => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByValueOfBlock < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => lambda { 'baz' },
                                                :error => RuntimeError,
                                                :error_message => 'pwop')
          b = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => lambda { 'bat' },
                                                :error => RuntimeError,
                                                :error_message => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByResultError < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => lambda { 'baz' },
                                                :error => RuntimeError,
                                                :error_message => 'bat')
          b = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => lambda { 'baz' },
                                                :error => Exception,
                                                :error_message => 'bat')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByResultErrorMessage < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => lambda { 'baz' },
                                                :error => RuntimeError,
                                                :error_message => 'bat')
          b = Trapeze::MethodProbeResult.raised(:method_name => 'foo',
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
          baz = lambda { 'baz' }
          a = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => baz,
                                                :thrown => 'bat')
          b = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => baz,
                                                :thrown => 'bat')
          assert_equal(true, (a == b))
        end
        
      end
      
      class DifferingByArgs < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => lambda { 'bat' },
                                                :thrown => 'pwop')
          b = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                :args => 'baz',
                                                :block => lambda { 'bat' },
                                                :thrown => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByValueOfBlock < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => lambda { 'baz' },
                                                :thrown => 'pwop')
          b = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => lambda { 'bat' },
                                                :thrown => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByResult < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => lambda { 'baz' },
                                                :thrown => 'bat')
          b = Trapeze::MethodProbeResult.thrown(:method_name => 'foo',
                                                :args => 'bar',
                                                :block => lambda { 'baz' },
                                                :thrown => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
    end
    
  end
  
end

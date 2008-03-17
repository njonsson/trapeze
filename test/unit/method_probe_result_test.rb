require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/method_probe_result")
require 'test/unit'

module Trapeze::MethodProbeResultTest
  
  class Allocate < Test::Unit::TestCase
    
    def test_should_raise_no_method_error
      assert_raise(NoMethodError) { Trapeze::MethodProbeResult.allocate }
    end
    
  end
  
  class New < Test::Unit::TestCase
    
    def test_should_raise_no_method_error
      assert_raise(NoMethodError) { Trapeze::MethodProbeResult.new }
    end
    
  end
  
  module Raised
    
    class WithNoArgs < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise(ArgumentError) { Trapeze::MethodProbeResult.raised }
      end
      
    end
    
    class WithNilMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise(ArgumentError) do
          Trapeze::MethodProbeResult.raised :method_name => nil
        end
      end
      
    end
    
    class WithMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise(ArgumentError) do
          Trapeze::MethodProbeResult.raised :method_name => 'foo'
        end
      end
      
    end
    
    class WithMethodNameAttributeAndArgsAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise(ArgumentError) do
          Trapeze::MethodProbeResult.raised :method_name => 'foo',
                                            :args => 'bar'
        end
      end
      
    end
    
    class WithMethodNameAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise(ArgumentError) do
          Trapeze::MethodProbeResult.raised :method_name => 'foo',
                                            :block => lambda { Time.now }
        end
      end
      
    end
    
    class WithMethodNameAttributeAndArgsAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise(ArgumentError) do
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
        assert_raise(ArgumentError) do
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
        assert_raise(ArgumentError) { Trapeze::MethodProbeResult.returned }
      end
      
    end
    
    class WithNilMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise(ArgumentError) do
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
        assert_raise(ArgumentError) { Trapeze::MethodProbeResult.thrown }
      end
      
    end
    
    class WithNilMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise(ArgumentError) do
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
  
end

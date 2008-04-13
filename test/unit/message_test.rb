require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/message")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/../assertion_helpers_extension")

module Trapeze::MessageTest
  
  class Allocate < Test::Unit::TestCase
    
    def test_should_raise_no_method_error
      assert_raise_message(NoMethodError, /private method `allocate' called/) do
        Trapeze::Message.allocate
      end
    end
    
  end
  
  class New < Test::Unit::TestCase
    
    def test_should_raise_no_method_error
      assert_raise_message(NoMethodError, /private method `new' called/) do
        Trapeze::Message.new
      end
    end
    
  end
  
  module Raised
    
    class WithNoArgs < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::Message.raised
        end
      end
      
    end
    
    class WithUnexpectedAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':foo attribute unexpected') do
          Trapeze::Message.raised :foo => 'bar'
        end
      end
      
    end
    
    class WithNilMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::Message.raised :method_name => nil
        end
      end
      
    end
    
    class WithMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::Message.raised :method_name => 'foo'
        end
      end
      
    end
    
    class WithMethodNameAttributeAndArgsAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::Message.raised :method_name => 'foo', :args => 'bar'
        end
      end
      
    end
    
    class WithMethodNameAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::Message.raised :method_name => 'foo',
                                  :block => lambda { Time.now }
        end
      end
      
    end
    
    class WithMethodNameAttributeAndArgsAttributeAndBlockAttribute <
          Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::Message.raised :method_name => 'foo',
                                  :args => 'bar',
                                  :block => lambda { Time.now }
        end
      end
      
    end
    
    class WithMethodNameAttributeAndNilArgsAttributeAndErrorAttribute <
          Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.raised(:method_name => 'foo',
                                           :args => nil,
                                           :error => RuntimeError)
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_array_containing_nil_when_sent_args
        assert_equal [nil], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:raised => {:error => RuntimeError}},
                     @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndEmptyArgsAttributeAndErrorAttribute <
          Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.raised(:method_name => 'foo',
                                           :args => [],
                                           :error => RuntimeError)
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:raised => {:error => RuntimeError}},
                     @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndArgsAttributeAndErrorAttribute <
          Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.raised(:method_name => 'foo',
                                           :args => 'bar',
                                           :error => RuntimeError)
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_array_containing_expected_arg_when_sent_args
        assert_equal ['bar'], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:raised => {:error => RuntimeError}},
                     @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndArrayArgsAttributeAndErrorAttribute <
          Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.raised(:method_name => 'foo',
                                           :args => ['bar'],
                                           :error => RuntimeError)
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:raised => {:error => RuntimeError}},
                     @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndNilBlockAttributeAndErrorAttribute <
          Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.raised(:method_name => 'foo',
                                           :block => nil,
                                           :error => RuntimeError)
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:raised => {:error => RuntimeError}},
                     @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndBlockAttributeAndErrorAttribute <
          Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @message = Trapeze::Message.raised(:method_name => 'foo',
                                           :block => lambda { @time },
                                           :error => RuntimeError)
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @message.block.call
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:raised => {:error => RuntimeError}},
                     @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndArgsAttributeAndBlockAttributeAndErrorAttribute <
          Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @message = Trapeze::Message.raised(:method_name => 'foo',
                                           :args => 'bar',
                                           :block => lambda { @time },
                                           :error => RuntimeError)
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @message.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @message.block.call
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:raised => {:error => RuntimeError}},
                     @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndArgsAttributeAndBlockAttributeAndErrorAttributeAndErrorMessageAttribute <
          Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @message = Trapeze::Message.raised(:method_name => 'foo',
                                           :args => 'bar',
                                           :block => lambda { @time },
                                           :error => RuntimeError,
                                           :error_message => 'baz')
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @message.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @message.block.call
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:raised => {:error => RuntimeError, :message => 'baz'}},
                     @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndNilErrorAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':error attribute required') do
          Trapeze::Message.raised :method_name => 'foo', :error => nil
        end
      end
      
    end
    
    class WithMethodNameAttributeAndErrorAttribute < Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.raised(:method_name => 'foo',
                                           :error => RuntimeError)
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:raised => {:error => RuntimeError}},
                     @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndErrorAttributeAndNilErrorMessageAttribute <
          Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.raised(:method_name => 'foo',
                                           :error => RuntimeError,
                                           :error_message => nil)
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:raised => {:error => RuntimeError}},
                     @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndErrorAttributeAndErrorMessageAttribute <
          Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.raised(:method_name => 'foo',
                                           :error => RuntimeError,
                                           :error_message => 'bar')
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:raised => {:error => RuntimeError,
                                  :message => 'bar'}},
                     @message.reply)
      end
      
    end
    
  end
  
  module Returned
    
    class WithNoArgs < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::Message.returned
        end
      end
      
    end
    
    class WithUnexpectedAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':foo attribute unexpected') do
          Trapeze::Message.returned :foo => 'bar'
        end
      end
      
    end
    
    class WithNilMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::Message.returned :method_name => nil
        end
      end
      
    end
    
    class WithMethodNameAttribute < Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.returned(:method_name => 'foo')
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:returned => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndNilArgsAttribute < Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.returned(:method_name => 'foo',
                                             :args => nil)
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_array_containing_nil_when_sent_args
        assert_equal [nil], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:returned => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndEmptyArgsAttribute < Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.returned(:method_name => 'foo', :args => [])
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:returned => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndArgsAttribute < Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.returned(:method_name => 'foo',
                                             :args => 'bar')
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_array_containing_expected_arg_when_sent_args
        assert_equal ['bar'], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:returned => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndArrayArgsAttribute < Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.returned(:method_name => 'foo',
                                             :args => ['bar'])
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:returned => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndNilBlockAttribute < Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.returned(:method_name => 'foo',
                                             :block => nil)
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:returned => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @message = Trapeze::Message.returned(:method_name => 'foo',
                                             :block => lambda { @time })
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @message.block.call
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:returned => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndArgsAttributeAndBlockAttribute <
          Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @message = Trapeze::Message.returned(:method_name => 'foo',
                                             :args => 'bar',
                                             :block => lambda { @time })
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @message.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @message.block.call
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:returned => nil}, @message.reply)
      end
      
    end
    
  end
  
  module Thrown
    
    class WithNoArgs < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::Message.thrown
        end
      end
      
    end
    
    class WithUnexpectedAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError, ':foo attribute unexpected') do
          Trapeze::Message.thrown :foo => 'bar'
        end
      end
      
    end
    
    class WithNilMethodNameAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':method_name attribute required') do
          Trapeze::Message.thrown :method_name => nil
        end
      end
      
    end
    
    class WithMethodNameAttribute < Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.thrown(:method_name => 'foo')
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:thrown => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndNilArgsAttribute < Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.thrown(:method_name => 'foo', :args => nil)
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_array_containing_nil_when_sent_args
        assert_equal [nil], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:thrown => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndEmptyArgsAttribute < Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.thrown(:method_name => 'foo', :args => [])
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:thrown => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndArgsAttribute < Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.thrown(:method_name => 'foo',
                                           :args => 'bar')
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_array_containing_expected_arg_when_sent_args
        assert_equal ['bar'], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:thrown => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndArrayArgsAttribute < Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.thrown(:method_name => 'foo',
                                           :args => ['bar'])
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:thrown => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndNilBlockAttribute < Test::Unit::TestCase
      
      def setup
        @message = Trapeze::Message.thrown(:method_name => 'foo', :block => nil)
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_nil_when_sent_block
        assert_nil @message.block
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:thrown => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndBlockAttribute < Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @message = Trapeze::Message.thrown(:method_name => 'foo',
                                           :block => lambda { @time })
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_empty_array_when_sent_args
        assert_equal [], @message.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @message.block.call
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:thrown => nil}, @message.reply)
      end
      
    end
    
    class WithMethodNameAttributeAndArgsAttributeAndBlockAttribute <
          Test::Unit::TestCase
      
      def setup
        @time = Time.now
        @message = Trapeze::Message.thrown(:method_name => 'foo',
                                           :args => 'bar',
                                           :block => lambda { @time })
      end
      
      def test_should_return_expected_method_name_when_sent_method_name
        assert_equal 'foo', @message.method_name
      end
      
      def test_should_return_expected_array_when_sent_args
        assert_equal ['bar'], @message.args
      end
      
      def test_should_return_expected_block_when_sent_block
        assert_equal @time, @message.block.call
      end
      
      def test_should_return_expected_hash_when_sent_reply
        assert_equal({:thrown => nil}, @message.reply)
      end
      
    end
    
  end
  
  module EQUALEQUAL
    
    module WithReturnedObject
      
      class Equivalent < Test::Unit::TestCase
        
        def test_should_return_true
          baz = lambda { 'baz' }
          a = Trapeze::Message.returned(:method_name => 'foo',
                                        :args => 'bar',
                                        :block => baz,
                                        :returned => 'bat')
          b = Trapeze::Message.returned(:method_name => 'foo',
                                        :args => 'bar',
                                        :block => baz,
                                        :returned => 'bat')
          assert_equal(true, (a == b))
        end
        
      end
      
      class DifferingByArgs < Test::Unit::TestCase
        
        def test_should_return_false
          bat = lambda { 'bat' }
          a = Trapeze::Message.returned(:method_name => 'foo',
                                        :args => 'bar',
                                        :block => bat,
                                        :returned => 'pwop')
          b = Trapeze::Message.returned(:method_name => 'foo',
                                        :args => 'baz',
                                        :block => bat,
                                        :returned => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByBlock < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::Message.returned(:method_name => 'foo',
                                        :args => 'bar',
                                        :block => lambda { 'baz' },
                                        :returned => 'bat')
          b = Trapeze::Message.returned(:method_name => 'foo',
                                        :args => 'bar',
                                        :block => lambda { 'baz' },
                                        :returned => 'bat')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByReply < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::Message.returned(:method_name => 'foo',
                                        :args => 'bar',
                                        :block => lambda { 'baz' },
                                        :returned => 'bat')
          b = Trapeze::Message.returned(:method_name => 'foo',
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
          a = Trapeze::Message.raised(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => baz,
                                      :error => RuntimeError,
                                      :error_message => 'bat')
          b = Trapeze::Message.raised(:method_name => 'foo',
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
          a = Trapeze::Message.raised(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => bat,
                                      :error => RuntimeError,
                                      :error_message => 'pwop')
          b = Trapeze::Message.raised(:method_name => 'foo',
                                      :args => 'baz',
                                      :block => bat,
                                      :error => RuntimeError,
                                      :error_message => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByBlock < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::Message.raised(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => lambda { 'baz' },
                                      :error => RuntimeError,
                                      :error_message => 'bat')
          b = Trapeze::Message.raised(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => lambda { 'baz' },
                                      :error => RuntimeError,
                                      :error_message => 'bat')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByReplyError < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::Message.raised(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => lambda { 'baz' },
                                      :error => RuntimeError,
                                      :error_message => 'bat')
          b = Trapeze::Message.raised(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => lambda { 'baz' },
                                      :error => Exception,
                                      :error_message => 'bat')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByReplyErrorMessage < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::Message.raised(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => lambda { 'baz' },
                                      :error => RuntimeError,
                                      :error_message => 'bat')
          b = Trapeze::Message.raised(:method_name => 'foo',
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
          a = Trapeze::Message.thrown(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => baz,
                                      :thrown => 'bat')
          b = Trapeze::Message.thrown(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => baz,
                                      :thrown => 'bat')
          assert_equal(true, (a == b))
        end
        
      end
      
      class DifferingByArgs < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::Message.thrown(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => lambda { 'bat' },
                                      :thrown => 'pwop')
          b = Trapeze::Message.thrown(:method_name => 'foo',
                                      :args => 'baz',
                                      :block => lambda { 'bat' },
                                      :thrown => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByBlock < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::Message.thrown(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => lambda { 'baz' },
                                      :thrown => 'bat')
          b = Trapeze::Message.thrown(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => lambda { 'baz' },
                                      :thrown => 'bat')
          assert_equal(false, (a == b))
        end
        
      end
      
      class DifferingByReply < Test::Unit::TestCase
        
        def test_should_return_false
          a = Trapeze::Message.thrown(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => lambda { 'baz' },
                                      :thrown => 'bat')
          b = Trapeze::Message.thrown(:method_name => 'foo',
                                      :args => 'bar',
                                      :block => lambda { 'baz' },
                                      :thrown => 'pwop')
          assert_equal(false, (a == b))
        end
        
      end
      
    end
    
  end
  
end

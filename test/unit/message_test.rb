require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/message")
require 'test/unit'

module Trapeze::MessageTest
  
  class WithNoAttributes < Test::Unit::TestCase
    
    def test_should_raise_argument_error
      assert_raise(ArgumentError) { Trapeze::Message.new }
    end
    
  end
  
  class WithMethodNameAttribute < Test::Unit::TestCase
    
    def setup
      @message = Trapeze::Message.new(:method_name => 'foo')
    end
    
    def test_should_return_true_when_sent_EQUALEQUAL_with_equivalent_message
      other_message = Trapeze::Message.new(:method_name => 'foo')
      assert_equal(true, (@message == other_message))
    end
    
    def test_should_return_false_when_sent_EQUALEQUAL_with_nonequivalent_message
      other_message = Trapeze::Message.new(:method_name => 'bar')
      assert_equal(false, (@message == other_message))
    end
    
    def test_should_return_expected_value_when_sent_method_name
      assert_equal 'foo', @message.method_name
    end
    
    def test_should_return_empty_array_when_sent_args
      assert_equal([], @message.args)
    end
    
    def test_should_return_empty_array_when_sent_args_and_block
      assert_equal([], @message.args_and_block)
    end
    
    def test_should_return_nil_when_sent_block
      assert_nil @message.block
    end
    
    def test_should_return_nil_when_sent_returned
      assert_nil @message.returned
    end
    
  end
  
  class WithMethodNameAndArgsAttributes < Test::Unit::TestCase
    
    def setup
      @message = Trapeze::Message.new(:method_name => 'foo', :args => %w(bar baz))
    end
    
    def test_should_return_true_when_sent_EQUALEQUAL_with_equivalent_message
      other_message = Trapeze::Message.new(:method_name => 'foo',
                                           :args => %w(bar baz))
      assert_equal(true, (@message == other_message))
    end
    
    def test_should_return_false_when_sent_EQUALEQUAL_with_nonequivalent_message
      other_message = Trapeze::Message.new(:method_name => 'baz',
                                           :args => %w(bar foo))
      assert_equal(false, (@message == other_message))
    end
    
    def test_should_return_expected_value_when_sent_method_name
      assert_equal 'foo', @message.method_name
    end
    
    def test_should_return_array_of_expected_values_when_sent_args
      assert_equal(%w(bar baz), @message.args)
    end
    
    def test_should_return_array_of_expected_values_when_sent_args_and_block
      assert_equal(%w(bar baz), @message.args_and_block)
    end
    
    def test_should_return_nil_when_sent_block
      assert_nil @message.block
    end
    
    def test_should_return_nil_when_sent_returned
      assert_nil @message.returned
    end
    
  end
  
  class WithMethodNameAndArgsAndBlockAttributes < Test::Unit::TestCase
    
    def setup
      @message = Trapeze::Message.new(:method_name => 'foo',
                                      :args => %w(bar baz),
                                      :block => lambda { 'bat' })
    end
    
    def test_should_return_true_when_sent_EQUALEQUAL_with_equivalent_message
      other_message = Trapeze::Message.new(:method_name => 'foo',
                                           :args => %w(bar baz),
                                           :block => @message.block)
      assert_equal(true, (@message == other_message))
    end
    
    def test_should_return_false_when_sent_EQUALEQUAL_with_nonequivalent_message
      other_message = Trapeze::Message.new(:method_name => 'bat',
                                           :args => %w(baz bar),
                                           :block => lambda { 'foo' })
      assert_equal(false, (@message == other_message))
    end
    
    def test_should_return_expected_value_when_sent_method_name
      assert_equal 'foo', @message.method_name
    end
    
    def test_should_return_array_of_expected_values_when_sent_args
      assert_equal(%w(bar baz), @message.args)
    end
    
    def test_should_return_array_containing_expected_values_and_block_when_sent_args_and_block
      assert_equal 3, @message.args_and_block.length
      assert_equal(%w(bar baz), @message.args_and_block[0..1])
      assert_equal 'bat', @message.args_and_block[2].call
    end
    
    def test_should_return_block_evaluating_to_expected_value_when_sent_block
      assert_equal 'bat', @message.block.call
    end
    
    def test_should_return_nil_when_sent_returned
      assert_nil @message.returned
    end
    
  end
  
  class WithMethodNameAndBlockAttributes < Test::Unit::TestCase
    
    def setup
      @message = Trapeze::Message.new(:method_name => 'foo',
                                      :block => lambda { 'bar' })
    end
    
    def test_should_return_true_when_sent_EQUALEQUAL_with_equivalent_message
      other_message = Trapeze::Message.new(:method_name => 'foo',
                                           :block => @message.block)
      assert_equal(true, (@message == other_message))
    end
    
    def test_should_return_false_when_sent_EQUALEQUAL_with_nonequivalent_message
      other_message = Trapeze::Message.new(:method_name => 'bar',
                                           :block => lambda { 'foo' })
      assert_equal(false, (@message == other_message))
    end
    
    def test_should_return_expected_value_when_sent_method_name
      assert_equal 'foo', @message.method_name
    end
    
    def test_should_return_empty_array_when_sent_args
      assert_equal([], @message.args)
    end
    
    def test_should_return_array_containing_expected_block_when_sent_args_and_block
      assert_equal 1, @message.args_and_block.length
      assert_equal 'bar', @message.args_and_block[0].call
    end
    
    def test_should_return_block_evaluating_to_expected_value_when_sent_block
      assert_equal 'bar', @message.block.call
    end
    
    def test_should_return_nil_when_sent_returned
      assert_nil @message.returned
    end
    
  end
  
  class WithMethodNameAndReturnedAttributes < Test::Unit::TestCase
    
    def setup
      @message = Trapeze::Message.new(:method_name => 'foo', :returned => 'bar')
    end
    
    def test_should_return_expected_value_when_sent_method_name
      assert_equal 'foo', @message.method_name
    end
    
    def test_should_return_empty_array_when_sent_args
      assert_equal([], @message.args)
    end
    
    def test_should_return_empty_array_when_sent_args_and_block
      assert_equal([], @message.args_and_block)
    end
    
    def test_should_return_nil_when_sent_block
      assert_nil @message.block
    end
    
    def test_should_return_expected_value_when_sent_returned
      assert_equal 'bar', @message.returned
    end
    
  end
  
end

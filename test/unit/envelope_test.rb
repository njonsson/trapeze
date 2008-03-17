require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/envelope")
require File.expand_path("#{File.dirname __FILE__}/../../lib/message")
require 'test/unit'

module Trapeze::EnvelopeTest
  
  class Klass < Test::Unit::TestCase
    
    def test_should_include_enumerable_among_ancestors
      assert_equal true, Trapeze::Envelope.ancestors.include?(Enumerable)
    end
    
    def test_should_raise_argument_error_when_sent_new_with_symbol
      assert_raise(ArgumentError) { Trapeze::Envelope.new :foo }
    end
    
    def test_should_raise_argument_error_when_sent_new_with_message_and_symbol
      assert_raise(ArgumentError) do
        Trapeze::Envelope.new Trapeze::Message.new(:method_name => 'foo'), :bar
      end
    end
    
    def test_should_not_raise_when_sent_new_with_one_message
      assert_nothing_raised do
        Trapeze::Envelope.new Trapeze::Message.new(:method_name => 'foo')
      end
    end
    
    def test_should_not_raise_when_sent_new_with_two_messages
      assert_nothing_raised do
        Trapeze::Envelope.new Trapeze::Message.new(:method_name => 'foo')
        Trapeze::Envelope.new Trapeze::Message.new(:method_name => 'bar')
      end
    end
    
  end
  
  class Empty < Test::Unit::TestCase
    
    def setup
      @envelope = Trapeze::Envelope.new
    end
    
    def test_should_return_nil_when_sent_LEFTBRACKETRIGHTBRACKET_with_zero
      assert_nil @envelope[0]
    end
    
    def test_should_return_nil_when_sent_LEFTBRACKETRIGHTBRACKET_with_one
      assert_nil @envelope[1]
    end
    
#    def test_should_raise_argument_error_when_sent_LEFTBRACKETRIGHTBRACKETEQUAL_with_zero_and_symbol
#      assert_raise(ArgumentError) { @envelope[0] = :foo }
#    end
#    
#    def test_should_increment_size_when_sent_LEFTBRACKETRIGHTBRACKETEQUAL_with_zero_and_message
#      size_before = @envelope.size
#      @envelope[0] = Trapeze::Message.new(:method_name => 'foo')
#      assert_equal size_before + 1, @envelope.size
#    end
#    
#    def test_should_increment_size_when_sent_LEFTBRACKETRIGHTBRACKETEQUAL_with_zero_and_message
#      size_before = @envelope.size
#      @envelope[0] = Trapeze::Message.new(:method_name => 'foo')
#      assert_equal size_before + 1, @envelope.size
#    end
    
    def test_should_raise_argument_error_when_sent_LESSTHANLESSTHAN_with_symbol
      assert_raise(ArgumentError) { @envelope << :foo }
    end
    
    def test_should_increment_size_when_sent_LESSTHANLESSTHAN_with_message
      size_before = @envelope.size
      @envelope << Trapeze::Message.new(:method_name => 'foo')
      assert_equal size_before + 1, @envelope.size
    end
    
    def test_should_return_true_when_sent_EQUALEQUAL_with_empty_envelope
      assert_equal(true, (@envelope == Trapeze::Envelope.new))
    end
    
    def test_should_not_require_a_block_when_sent_each
      assert_nothing_raised { @envelope.each }
    end
    
    def test_should_return_empty_array_when_sent_each
      assert_equal [], @envelope.each
    end
    
    def test_should_not_yield_when_sent_each
      @envelope.each { |m| flunk }
    end
    
    def test_should_return_true_when_sent_emptyQUESTION
      assert_equal true, @envelope.empty?
    end
    
    def test_should_return_nil_when_sent_first
      assert_nil @envelope.first
    end
    
    def test_should_return_nil_when_sent_last
      assert_nil @envelope.last
    end
    
    def test_should_return_zero_when_sent_length
      assert_equal 0, @envelope.length
    end
    
    def test_should_return_zero_when_sent_size
      assert_equal 0, @envelope.size
    end
    
  end
  
  class WithOneMessage < Test::Unit::TestCase
    
    def setup
      @message = Trapeze::Message.new(:method_name => 'foo')
      @envelope = Trapeze::Envelope.new(@message)
    end
    
    def test_should_return_expected_message_when_sent_LEFTBRACKETRIGHTBRACKET_with_zero
      assert_equal @message, @envelope[0]
    end
    
    def test_should_return_nil_when_sent_LEFTBRACKETRIGHTBRACKET_with_one
      assert_nil @envelope[1]
    end
    
#    def test_should_raise_argument_error_when_sent_LEFTBRACKETRIGHTBRACKETEQUAL_with_zero_and_symbol
#      assert_raise(ArgumentError) { @envelope[0] = :foo }
#    end
#    
#    def test_should_not_increment_size_when_sent_LEFTBRACKETRIGHTBRACKETEQUAL_with_zero_and_message
#      size_before = @envelope.size
#      @envelope[0] = Trapeze::Message.new(:method_name => 'foo')
#      assert_equal size_before, @envelope.size
#    end
    
    def test_should_raise_argument_error_when_sent_LESSTHANLESSTHAN_with_symbol
      assert_raise(ArgumentError) { @envelope << :foo }
    end
    
    def test_should_increment_size_when_sent_LESSTHANLESSTHAN_with_message
      size_before = @envelope.size
      @envelope << Trapeze::Message.new(:method_name => 'foo')
      assert_equal size_before + 1, @envelope.size
    end
    
    def test_should_return_false_when_sent_EQUALEQUAL_with_empty_envelope
      assert_equal(false, (@envelope == Trapeze::Envelope.new))
    end
    
    def test_should_return_true_when_sent_EQUALEQUAL_with_equivalent_envelope
      assert_equal(true,
                   (@envelope == Trapeze::Envelope.new(Trapeze::Message.new(:method_name => 'foo'))))
    end
    
    def test_should_require_a_block_when_sent_each
      assert_raise(LocalJumpError) { @envelope.each }
    end
    
    def test_should_return_array_of_expected_message_when_sent_each
      assert_equal([@message], @envelope.each { })
    end
    
    def test_should_yield_expected_message_once_when_sent_each
      @messages = []
      @envelope.each { |m| @messages << m }
      assert_equal [@message], @messages
    end
    
    def test_should_return_false_when_sent_emptyQUESTION
      assert_equal false, @envelope.empty?
    end
    
    def test_should_return_expected_message_when_sent_first
      assert_equal @message, @envelope.first
    end
    
    def test_should_return_expected_message_when_sent_last
      assert_equal @message, @envelope.last
    end
    
    def test_should_return_one_when_sent_length
      assert_equal 1, @envelope.length
    end
    
    def test_should_return_one_when_sent_size
      assert_equal 1, @envelope.size
    end
    
  end
  
end

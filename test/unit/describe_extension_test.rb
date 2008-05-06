require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/describe_extension")
require 'test/unit'
require 'bigdecimal'
require 'date'
require 'rubygems'
require 'mocha'

module Trapeze::DescribeExtensionTest
  
  class Scalar < Test::Unit::TestCase
    
    class Foo; end
    
    def test_nil_should_return_expected_description_when_sent_describe
      assert_equal 'nil', nil._describe
    end
    
    def test_string_of_one_word_should_return_expected_description_when_sent_describe
      assert_equal '"foo"', 'foo'._describe
    end
    
    def test_string_of_two_words_should_return_expected_description_when_sent_describe
      assert_equal '"foo bar"', 'foo bar'._describe
    end
    
    def test_symbol_of_one_word_should_return_expected_description_when_sent_describe
      assert_equal ':foo', :foo._describe
    end
    
    def test_symbol_of_two_words_should_return_expected_description_when_sent_describe
      assert_equal ':foo_bar', :foo_bar._describe
    end
    
    def test_fixnum_should_return_expected_description_when_sent_describe
      assert_equal '777', 777._describe
    end
    
    def test_bignum_should_return_expected_description_when_sent_describe
      bignum = ('7' * 30).to_i
      assert_instance_of Bignum, bignum # Sanity check
      assert_equal '7' * 30, bignum._describe
    end
    
    def test_float_should_return_expected_description_when_sent_describe
      assert_equal '7.77', 7.77._describe
    end
    
    def test_big_decimal_should_return_expected_description_when_sent_describe
      assert_equal '0.777E1', BigDecimal.new('7.77')._describe
    end
    
    def test_class_should_return_expected_description_when_sent_describe
      assert_equal 'Trapeze::DescribeExtensionTest::Scalar::Foo', Foo._describe
    end
    
    def test_object_should_return_expected_description_when_sent_describe
      assert_equal 'an Object object', Object.new._describe
    end
    
    def test_custom_object_should_return_expected_description_when_sent_describe
      assert_equal 'a Trapeze::DescribeExtensionTest::Scalar::Foo object',
                   Foo.new._describe
    end
    
    def test_sandboxed_object_should_return_expected_description_when_sent_describe
      stubbed_class = ('Foo')
      stubbed_class.stubs(:name).returns 'Trapeze::Sandbox1234::Foo'
      stubbed_object = mock('Foo object')
      stubbed_object.stubs(:class).returns stubbed_class
      assert_equal 'a Foo object', stubbed_object._describe
    end
    
    def test_true_should_return_expected_description_when_sent_describe
      assert_equal 'true', true._describe
    end
    
    def test_false_should_return_expected_description_when_sent_describe
      assert_equal 'false', false._describe
    end
    
    def test_regexp_should_return_expected_description_when_sent_describe
      assert_equal 'a Regexp object', /foo bar/._describe
    end
    
    def test_date_should_return_expected_description_when_sent_describe
      assert_equal '1999-12-31', Date.civil(1999, 12, 31)._describe
    end
    
    def test_datetime_should_return_expected_description_when_sent_describe
      assert_equal '1999-12-31T23:59:59+00:00',
                   DateTime.civil(1999, 12, 31, 23, 59, 59)._describe
    end
    
    def test_time_should_return_expected_description_when_sent_describe
      assert_equal 'Fri Dec 31 23:59:59 UTC 1999',
                   Time.gm(1999, 12, 31, 23, 59, 59)._describe
    end
    
  end
  
  class Range < Test::Unit::TestCase
    
    def test_from_zero_through_one_should_return_expected_description_when_sent_describe
      assert_equal 'a range from zero through one', (0..1)._describe
    end
    
    def test_from_zero_up_to_one_should_return_expected_description_when_sent_describe
      assert_equal 'a range from zero to and excluding one', (0...1)._describe
    end
    
    def test_from_zero_through_1POINT1_should_return_expected_description_when_sent_describe
      assert_equal 'a range from zero through 1.1', (0..1.1)._describe
    end
    
    def test_from_zero_up_to_1POINT1_should_return_expected_description_when_sent_describe
      assert_equal 'a range from zero to and excluding 1.1', (0...1.1)._describe
    end
    
    def test_from_MINUSone_through_zero_should_return_expected_description_when_sent_describe
      assert_equal 'a range from -1 through zero', (-1..0)._describe
    end
    
    def test_from_MINUSone_up_to_zero_should_return_expected_description_when_sent_describe
      assert_equal 'a range from -1 to and excluding zero', (-1...0)._describe
    end
    
    def test_from_10_through_11_should_return_expected_description_when_sent_describe
      assert_equal 'a range from 10 through 11', (10..11)._describe
    end
    
    def test_from_10_up_to_11_should_return_expected_description_when_sent_describe
      assert_equal 'a range from 10 to and excluding 11', (10...11)._describe
    end
    
  end
  
  class Array < Test::Unit::TestCase
    
    def test_empty_should_return_expected_description_when_sent_describe
      assert_equal 'an empty array', []._describe
    end
    
    def test_of_one_objects_should_return_expected_description_when_sent_describe
      assert_equal 'an array containing :foo', [:foo]._describe
    end
    
    def test_of_two_objects_should_return_expected_description_when_sent_describe
      assert_equal 'an array containing :foo and :bar', [:foo, :bar]._describe
    end
    
    def test_of_three_objects_should_return_expected_description_when_sent_describe
      assert_equal 'an array containing :foo, :bar and :baz',
                   [:foo, :bar, :baz]._describe
    end
    
    def test_of_four_objects_should_return_expected_description_when_sent_describe
      assert_equal 'an array of four objects',
                   [:foo, :bar, :baz, :bat]._describe
    end
    
    def test_of_nine_objects_should_return_expected_description_when_sent_describe
      actual = [:foo,
                :bar,
                :baz,
                :bat,
                :pwop,
                :ding,
                :dit,
                :dot,
                :doot]._describe
      assert_equal 'an array of nine objects', actual
    end
    
    def test_of_10_objects_return_expected_description_when_sent_describe
      actual = [:foo,
                :bar,
                :baz,
                :bat,
                :pwop,
                :ding,
                :dit,
                :dot,
                :doot,
                :deet]._describe
      assert_equal 'an array of 10 objects', actual
    end
    
  end
  
  class Hash < Test::Unit::TestCase
    
    def test_empty_should_return_expected_description_when_sent_describe
      assert_equal 'an empty hash', {}._describe
    end
    
    def test_of_one_value_should_return_expected_description_when_sent_describe
      assert_equal 'a hash containing :bar with a key of :foo',
                   {:foo => :bar}._describe
    end
    
    def test_of_two_values_should_return_expected_description_when_sent_describe
      expected = 'a hash containing :bat with a key of :baz and ' +
                                   ':bar with a key of :foo'
      assert_equal expected, {:foo => :bar, :baz => :bat}._describe
    end
    
    def test_of_three_values_should_return_expected_description_when_sent_describe
      expected = 'a hash containing :bat with a key of :baz, '    +
                                   ':bar with a key of :foo and ' +
                                   ':ding with a key of :pwop'
      assert_equal expected,
                   {:foo => :bar, :baz => :bat, :pwop => :ding}._describe
    end
    
    def test_of_four_values_should_return_expected_description_when_sent_describe
      actual = {:foo => :bar,
                :baz => :bat,
                :pwop => :ding,
                :dit => :dot}._describe
      assert_equal 'a hash of four values', actual
    end
    
    def test_of_nine_values_should_return_expected_description_when_sent_describe
      actual = {:foo => :bar,
                :baz => :bat,
                :pwop => :ding,
                :dit => :dot,
                :doot => :deet,
                :bin => :ban,
                :con => :can,
                :fin => :fan,
                :goon => :gan}._describe
      assert_equal 'a hash of nine values', actual
    end
    
    def test_of_10_values_should_return_expected_description_when_sent_describe
      actual = {:foo => :bar,
                :baz => :bat,
                :pwop => :ding,
                :dit => :dot,
                :doot => :deet,
                :bin => :ban,
                :con => :can,
                :fin => :fan,
                :goon => :gan,
                :hon => :han}._describe
      assert_equal 'a hash of 10 values', actual
    end
    
  end
  
end

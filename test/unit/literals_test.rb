require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/literals")
require 'test/unit'
require 'bigdecimal'
require 'complex'
require 'date'
require 'rational'

module Trapeze::LiteralsTest
  
  class Empty < Test::Unit::TestCase
    
    class Foo; end
    
    def setup
      @literals = Trapeze::Literals.new
    end
    
    def test_should_return_nil_for_an_object
      assert_nil @literals[Object.new]
    end
    
    def test_should_return_nil_as_the_literal_for_a_custom_object
      assert_nil @literals[Foo.new]
    end
    
    def test_should_return_self_when_adding_a_literal
      assert_equal @literals, @literals.[]=('Foo', lambda { })
    end
    
  end
  
  class WithALiteralForObjects < Test::Unit::TestCase
    
    class Foo; end
    
    def setup
      @literals = Trapeze::Literals.new
      @literal_value = rand
      @literals['Object'] = lambda { |o| @literal_value }
    end
    
    def test_should_return_the_expected_literal_for_an_object
      assert_equal @literal_value, @literals[Object.new]
    end
    
    def test_should_return_nil_as_the_literal_for_a_custom_object
      assert_nil @literals[Foo.new]
    end
    
    def test_should_return_self_when_adding_a_literal
      assert_equal @literals, @literals.[]=('Foo', lambda { })
    end
    
  end
  
  class WithALiteralForObjectsThatGetsRemoved < Test::Unit::TestCase
    
    class Foo; end
    
    def setup
      @literals = Trapeze::Literals.new
      @literals['Object'] = lambda { |o| rand }
      @literals['Object'] = nil
    end
    
    def test_should_return_nil_as_the_literal_for_an_object
      assert_nil @literals[Object.new]
    end
    
    def test_should_return_nil_as_the_literal_for_a_custom_object
      assert_nil @literals[Foo.new]
    end
    
    def test_should_return_self_when_adding_a_literal
      assert_equal @literals, @literals.[]=('Foo', lambda { })
    end
    
  end
  
  class BuiltIn < Test::Unit::TestCase
    
    class FooClass; end
    
    module BarModule; end
    
    def setup
      @literals = Trapeze::Literals.built_in
    end
    
    def test_should_return_nil_as_the_literal_for_an_unregistered_custom_object
      assert_nil @literals[FooClass.new]
    end
    
    def test_should_return_a_literal_for_an_array_that_evaluates_as_expected
      assert_correct_literal_for Array, []
    end
    
    def test_should_return_a_literal_for_a_big_decimal_that_evaluates_as_expected
      assert_correct_literal_for BigDecimal, BigDecimal.new('7.77')
    end
    
    def test_should_return_a_literal_for_a_bignum_that_evaluates_as_expected
      bignum = ('7' * 30).to_i
      assert_instance_of Bignum, bignum # Sanity check
      assert_correct_literal_for Bignum, bignum
    end
    
    def test_should_return_a_literal_for_a_class_that_evaluates_as_expected
      assert_correct_literal_for Class, FooClass
    end
    
    def test_should_return_a_literal_for_a_complex_that_evaluates_as_expected
      assert_correct_literal_for Complex, Complex(1, 2)
    end
    
    def test_should_return_a_literal_for_a_date_that_evaluates_as_expected
      assert_correct_literal_for Date, Date.civil(1999, 12, 31)
    end
    
    def test_should_return_a_literal_for_a_date_time_that_evaluates_as_expected
      assert_correct_literal_for DateTime, DateTime.civil(1999, 12, 31, 23, 59, 59)
    end
    
    def test_should_return_a_literal_for_false_that_evaluates_as_expected
      assert_correct_literal_for FalseClass, false
    end
    
    def test_should_return_a_literal_for_a_fixnum_that_evaluates_as_expected
      assert_correct_literal_for Fixnum, 777
    end
    
    def test_should_return_a_literal_for_a_float_that_evaluates_as_expected
      assert_correct_literal_for Float, 7.77
    end
    
    def test_should_return_a_literal_for_a_hash_that_evaluates_as_expected
      assert_correct_literal_for(Hash, {})
    end
    
    def test_should_return_a_literal_for_a_module_that_evaluates_as_expected
      assert_correct_literal_for Module, BarModule
    end
    
    def test_should_return_a_literal_for_a_range_that_evaluates_as_expected
      assert_correct_literal_for Range, 0..1
    end
    
    def test_should_return_a_literal_for_a_rational_that_evaluates_as_expected
      assert_correct_literal_for Rational, Rational(7, 22)
    end
    
    def test_should_return_a_literal_for_a_regexp_that_evaluates_as_expected
      assert_correct_literal_for Regexp, /foo bar/
    end
    
    def test_should_return_a_literal_for_a_string_that_evaluates_as_expected
      assert_correct_literal_for String, 'foo'
    end
    
    def test_should_return_a_literal_for_a_symbol_that_evaluates_as_expected
      assert_correct_literal_for Symbol, :foo
    end
    
    def test_should_return_a_literal_for_a_time_that_evaluates_as_expected
      assert_correct_literal_for Time, Time.gm(1999, 12, 31, 23, 59, 59)
    end
    
    def test_should_return_a_literal_for_true_that_evaluates_as_expected
      assert_correct_literal_for TrueClass, true
    end
    
    def test_should_return_self_when_adding_a_literal
      assert_equal @literals, @literals.[]=('Foo', lambda { })
    end
    
  private
    
    def assert_correct_literal_for(klass, value)
      assert_instance_of klass, value
      assert_equal value, eval(@literals[value])
    end
    
  end
  
end

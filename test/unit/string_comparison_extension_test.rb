require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/string_comparison_extension")
require 'test/unit'

class Trapeze::StringComparisonExtensionTest < Test::Unit::TestCase
  
  def test_should_compare_symbols_as_strings
    assert_equal('foo' <=> 'bar', :foo <=> :bar)
  end
  
  def test_should_compare_symbol_to_string_as_string_to_numeric
    assert_equal('foo' <=> 123, :foo <=> 'bar')
  end
  
end

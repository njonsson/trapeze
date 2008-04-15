require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/nesting_extension")
require 'test/unit'

class Trapeze::NestingExtensionTest < Test::Unit::TestCase
  
  def test_single
    assert_equal %w(foo), File.nesting('foo')
  end
  
  def test_slash_delimited
    assert_equal %w(foo bar), File.nesting('foo/bar')
  end
  
  def test_backslash_delimited
    assert_equal %w(foo bar), File.nesting('foo\bar')
  end
  
end

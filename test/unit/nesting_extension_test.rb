require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/nesting_extension")
require 'test/unit'

class Trapeze::NestingExtensionTest < Test::Unit::TestCase
  
  def test_single_should_return_expected_nesting_when_sent_UNDERSCOREnesting
    assert_equal %w(foo), File._nesting('foo')
  end
  
  def test_slash_delimited_should_return_expected_nesting_when_sent_UNDERSCOREnesting
    assert_equal %w(foo bar), File._nesting('foo/bar')
  end
  
  def test_backslash_delimited_should_return_expected_nesting_when_sent_UNDERSCOREnesting
    assert_equal %w(foo bar), File._nesting('foo\bar')
  end
  
end

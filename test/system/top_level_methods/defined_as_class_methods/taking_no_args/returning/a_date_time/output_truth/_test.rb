# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class Test_ < Test::Unit::TestCase
  
  def test_top_level_method_bar_should_return_2002_02_02_t02_02_02_00_00
    assert_equal DateTime.parse("2002-02-02T02:02:02+00:00"), eval('bar', TOPLEVEL_BINDING)
  end
  
  def test_top_level_method_foo_should_return_2001_01_01_t01_01_01_00_00
    assert_equal DateTime.parse("2001-01-01T01:01:01+00:00"), eval('foo', TOPLEVEL_BINDING)
  end
  
end

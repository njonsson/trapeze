# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class Test_ < Test::Unit::TestCase
  
  def test_top_level_method_bar_should_return_1_1i
    assert_equal Complex(1, 1), eval('bar', TOPLEVEL_BINDING)
  end
  
  def test_top_level_method_foo_should_return_1i
    assert_equal Complex(0, 1), eval('foo', TOPLEVEL_BINDING)
  end
  
end

# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class Test_ < Test::Unit::TestCase
  
  def test_top_level_method_bar_should_return_8_88
    assert_equal 8.88, eval('bar', TOPLEVEL_BINDING, __FILE__, __LINE__)
  end
  
  def test_top_level_method_foo_should_return_7_77
    assert_equal 7.77, eval('foo', TOPLEVEL_BINDING, __FILE__, __LINE__)
  end
  
end

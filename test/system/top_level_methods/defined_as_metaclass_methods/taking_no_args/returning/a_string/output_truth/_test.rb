# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class Test_ < Test::Unit::TestCase
  
  def test_top_level_method_baz_should_return_bat
    assert_equal "BAT!", eval('baz', TOPLEVEL_BINDING, __FILE__, __LINE__)
  end
  
  def test_top_level_method_foo_should_return_bar
    assert_equal "BAR!", eval('foo', TOPLEVEL_BINDING, __FILE__, __LINE__)
  end
  
end

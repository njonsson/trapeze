# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class Test_ < Test::Unit::TestCase
  
  def test_top_level_method_bar_should_return_nil
    assert_nil eval('bar', TOPLEVEL_BINDING)
  end
  
  def test_top_level_method_foo_should_return_nil
    assert_nil eval('foo', TOPLEVEL_BINDING)
  end
  
end

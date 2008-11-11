# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class Test_ < Test::Unit::TestCase
  
  def test_top_level_method_bar_should_return_bar
    assert_equal "BAR!", eval('bar', TOPLEVEL_BINDING, __FILE__, __LINE__)
  end
  
  def test_top_level_method_foo_should_raise_zero_division_error_with_message_of_divided_by_0
    begin
      eval 'foo', TOPLEVEL_BINDING, __FILE__, __LINE__
    rescue Exception => e
      assert_instance_of ZeroDivisionError, e
      assert_equal "divided by 0", e.message
    end
  end
  
end
# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class Test_ < Test::Unit::TestCase
  
  def test_should_return_1_1i_when_sent_bar
    assert_equal Complex(1, 1), bar
  end
  
  def test_should_return_1i_when_sent_foo
    assert_equal Complex(0, 1), foo
  end
  
end
# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class BatTest < Test::Unit::TestCase
  
  def setup
    @bat = Bat.new
  end
  
  def test_should_be_instance_of_class
    assert_instance_of Class, Bat
  end
  
  def test_should_return_a_range_from_nine_to_and_excluding_99_when_sent_ding
    assert_equal 9...99, @bat.ding
  end
  
  def test_should_return_a_range_from_eight_through_88_when_sent_pwop
    assert_equal 8..88, @bat.pwop
  end
  
end

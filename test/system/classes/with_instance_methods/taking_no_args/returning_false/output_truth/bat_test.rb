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
  
  def test_should_return_false_when_sent_ding
    assert_equal false, @bat.ding
  end
  
  def test_should_return_false_when_sent_pwop
    assert_equal false, @bat.pwop
  end
  
end

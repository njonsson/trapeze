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
  
  def test_should_return_0_999_e1_when_sent_ding
    assert_equal BigDecimal.new("0.999E1"), @bat.ding
  end
  
  def test_should_return_0_888_e1_when_sent_pwop
    assert_equal BigDecimal.new("0.888E1"), @bat.pwop
  end
  
end

# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class BatTest < Test::Unit::TestCase
  
  def setup
    @bat = Object.new
    @bat.extend Bat
  end
  
  def test_is_module
    assert_instance_of Module, Bat
  end
  
  def test_ding_returns_nil
    assert_nil @bat.ding
  end
  
  def test_pwop_returns_nil
    assert_nil @bat.pwop
  end
  
end

# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class BatTest < Test::Unit::TestCase
  
  def setup
    @bat = Object.new
    @bat.extend Bat
  end
  
  def test_should_be_instance_of_module
    assert_instance_of Module, Bat
  end
  
  def test_should_return_999_when_sent_ding
    assert_equal 999, @bat.ding
  end
  
  def test_should_return_888_when_sent_pwop
    assert_equal 888, @bat.pwop
  end
  
end
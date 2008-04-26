# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class DingTest < Test::Unit::TestCase
  
  def setup
    @ding = Ding.new
  end
  
  def test_should_be_instance_of_class
    assert_instance_of Class, Ding
  end
  
  def test_should_return_dot_when_sent_dit
    assert_equal "DOT!", @ding.dit
  end
  
  def test_should_return_deet_when_sent_doot
    assert_equal "DEET!", @ding.doot
  end
  
end
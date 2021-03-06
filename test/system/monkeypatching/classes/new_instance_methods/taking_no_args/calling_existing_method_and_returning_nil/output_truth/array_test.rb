# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class ArrayTest < Test::Unit::TestCase
  
  def setup
    @array = Array.new
  end
  
  def test_should_be_instance_of_class
    assert_instance_of Class, Array
  end
  
  def test_should_return_nil_when_sent_bar
    assert_nil @array.bar
  end
  
  def test_should_return_nil_when_sent_foo
    assert_nil @array.foo
  end
  
end

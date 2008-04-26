# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class FooTest < Test::Unit::TestCase
  
  def setup
    @foo = Foo.new
  end
  
  def test_is_class
    assert_instance_of Class, Foo
  end
  
  def test_bar_returns_666
    assert_equal 666, @foo.bar
  end
  
  def test_baz_returns_777
    assert_equal 777, @foo.baz
  end
  
end

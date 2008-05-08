# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class FooTest < Test::Unit::TestCase
  
  def setup
    @foo = Object.new
    @foo.extend Foo
  end
  
  def test_should_be_instance_of_module
    assert_instance_of Module, Foo
  end
  
  def test_should_return_foo_bar_when_sent_bar
    assert_equal Foo::Bar, @foo.bar
  end
  
  def test_should_return_foo_baz_when_sent_baz
    assert_equal Foo::Baz, @foo.baz
  end
  
end

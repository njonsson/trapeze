# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class FooTest < Test::Unit::TestCase
  
  def setup
    @foo = Foo.new
  end
  
  def test_should_be_instance_of_class
    assert_instance_of Class, Foo
  end
  
  def test_should_return_a_foo_bar_object_when_sent_bar
    assert_instance_of Foo::Bar, @foo.bar
    assert_equal :something, @foo.bar.instance_variable_get('@my_state')
  end
  
  def test_should_return_a_foo_baz_object_when_sent_baz
    assert_instance_of Foo::Baz, @foo.baz
    assert_equal :something_else, @foo.baz.instance_variable_get('@my_state')
  end
  
end

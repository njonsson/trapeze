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
  
  def test_should_return_a_regexp_object_when_sent_bar
    assert_equal /BAZ!/, @foo.bar
  end
  
  def test_should_return_a_regexp_object_when_sent_bat
    assert_equal /PWOP!/, @foo.bat
  end
  
end

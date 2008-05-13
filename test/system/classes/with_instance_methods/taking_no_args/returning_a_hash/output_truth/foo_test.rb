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
  
  def test_should_return_a_hash_containing_bat_with_a_key_of_baz_when_sent_bar
    assert_equal({:baz=>:bat}, @foo.bar)
  end
  
  def test_should_return_a_hash_containing_doot_with_a_key_of_ding_when_sent_pwop
    assert_equal({:ding=>:doot}, @foo.pwop)
  end
  
end

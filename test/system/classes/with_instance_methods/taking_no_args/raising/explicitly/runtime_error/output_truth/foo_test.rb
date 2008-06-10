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
  
  def test_should_raise_runtime_error_with_message_of_this_error_also_was_raised_intentionally_when_sent_bar
    begin
      @foo.bar
    rescue Exception => e
      assert_instance_of RuntimeError, e
      assert_equal "this error also was raised intentionally", e.message
    end
  end
  
  def test_should_return_baz_when_sent_baz
    assert_equal "BAZ!", @foo.baz
  end
  
end
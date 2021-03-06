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
  
  def test_should_return_2001_01_01_when_sent_bar
    assert_equal Date.parse("2001-01-01"), @foo.bar
  end
  
  def test_should_return_2002_02_02_when_sent_baz
    assert_equal Date.parse("2002-02-02"), @foo.baz
  end
  
end

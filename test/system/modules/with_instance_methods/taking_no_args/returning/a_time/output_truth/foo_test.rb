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
  
  def test_should_return_mon_jan_01_01_01_01_utc_2001_when_sent_bar
    assert_equal Time.utc(2001, 1, 1, 1, 1, 1, 1), @foo.bar
  end
  
  def test_should_return_sat_feb_02_02_02_02_utc_2002_when_sent_baz
    assert_equal Time.utc(2002, 2, 2, 2, 2, 2, 2), @foo.baz
  end
  
end

# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class Test_ < Test::Unit::TestCase
  
  def test_should_return_a_hash_containing_ding_with_a_key_of_pwop_when_sent_bat
    assert_equal({:pwop=>:ding}, bat)
  end
  
  def test_should_return_a_hash_containing_baz_with_a_key_of_bar_when_sent_foo
    assert_equal({:bar=>:baz}, foo)
  end
  
end

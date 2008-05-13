# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class DeetTest < Test::Unit::TestCase
  
  def setup
    @deet = Object.new
    @deet.extend Deet
  end
  
  def test_should_be_instance_of_module
    assert_instance_of Module, Deet
  end
  
  def test_should_return_a_hash_containing_can_with_a_key_of_con_when_sent_ban
    assert_equal({:con=>:can}, @deet.ban)
  end
  
  def test_should_return_a_hash_containing_bin_with_a_key_of_dot_when_sent_dit
    assert_equal({:dot=>:bin}, @deet.dit)
  end
  
end

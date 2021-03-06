# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class DootTest < Test::Unit::TestCase
  
  def setup
    @doot = Object.new
    @doot.extend Doot
  end
  
  def test_should_be_instance_of_module
    assert_instance_of Module, Doot
  end
  
  def test_should_return_deet_when_sent_deet
    assert_equal "DEET!", @doot.deet
  end
  
end

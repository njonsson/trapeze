# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class BatTest < Test::Unit::TestCase
  
  def setup
    @bat = Object.new
    @bat.extend Bat
  end
  
  def test_should_be_instance_of_module
    assert_instance_of Module, Bat
  end
  
  def test_should_return_ding_when_sent_ding
    assert_equal "DING!", @bat.ding
  end
  
  def test_should_raise_runtime_error_with_message_of_this_error_was_raised_intentionally_when_sent_pwop
    begin
      @bat.pwop
    rescue Exception => e
      assert_instance_of RuntimeError, e
      assert_equal "this error was raised intentionally", e.message
    end
  end
  
end

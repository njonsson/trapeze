# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class ArrayTest < Test::Unit::TestCase
  
  def setup
    @array = Array.new
  end
  
  def test_should_be_instance_of_class
    assert_instance_of Class, Array
  end
  
  def test_should_return_bat_when_sent_bat
    assert_equal "BAT!", @array.bat
  end
  
  def test_should_raise_no_method_error_with_args_of_an_empty_array_and_message_of_undefined_method_this_method_also_does_not_exist_for_array_and_name_of_this_method_also_does_not_exist_when_sent_baz
    begin
      @array.baz
    rescue Exception => e
      assert_instance_of NoMethodError, e
      assert_equal [], e.args
      assert_equal "undefined method `this_method_also_does_not_exist' for []:Array", e.message
      assert_equal :this_method_also_does_not_exist, e.name
    end
  end
  
end
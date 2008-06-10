# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class BatTest < Test::Unit::TestCase
  
  def setup
    @bat = Bat.new
  end
  
  def test_should_be_instance_of_class
    assert_instance_of Class, Bat
  end
  
  def test_should_return_ding_when_sent_ding
    assert_equal "DING!", @bat.ding
  end
  
  def test_should_raise_no_method_error_with_args_of_an_empty_array_and_message_of_a_string_matching_undefined_method_this_is_a_nonexistent_method_for_an_object_literal_and_name_of_this_is_a_nonexistent_method_when_sent_pwop
    begin
      @bat.pwop
    rescue Exception => e
      assert_instance_of NoMethodError, e
      assert_equal [], e.args
      assert_match /^undefined\ method\ `this_is_a_nonexistent_method'\ for\ \#<Bat:0x[0-9a-f]+>$/, e.message
      assert_equal :this_is_a_nonexistent_method, e.name
    end
  end
  
end
# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class ObjectTest < Test::Unit::TestCase
  
  def setup
    @object = Object.new
  end
  
  def test_should_be_instance_of_class
    assert_instance_of Class, Object
  end
  
  def test_should_return_bar_when_sent_bar
    assert_equal "BAR!", @object.bar
  end
  
  def test_should_raise_no_method_error_with_args_of_an_empty_array_and_message_of_a_string_matching_undefined_method_this_method_does_not_exist_for_an_object_literal_and_name_of_this_method_does_not_exist_when_sent_foo
    begin
      @object.foo
    rescue Exception => e
      assert_instance_of NoMethodError, e
      assert_equal [], e.args
      assert_match /^undefined\ method\ `this_method_does_not_exist'\ for\ \#<Object:0x[0-9a-f]+>$/, e.message
      assert_equal :this_method_does_not_exist, e.name
    end
  end
  
end
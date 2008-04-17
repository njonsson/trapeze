require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/to_method_extension")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/../assertion_helpers_extension")

module Trapeze::ToMethodExtensionTest
  
  class Foo
    
    class << self
      
      def bar; end
      
    end
    
    def self.baz; end
    
    def bat; end
    
  end
  
  module Pwop
    
    class << self
      
      def ding; end
      
    end
    
    def self.dit; end
    
    def dot; end
    
  end
  
  class UNDERSCOREToInstanceMethod < Test::Unit::TestCase
    
    def test_should_return_expected_method_definition_for_existing_instance_method_on_class
      assert_method ['bat', {:arity => 0}], 'bat'._to_instance_method(Foo)
    end
    
    def test_should_return_nil_for_nonexistent_method_on_class
      assert_nil 'foozle'._to_instance_method(Foo)
    end
    
    def test_should_return_expected_method_definition_for_existing_instance_method_on_module
      assert_method ['dot', {:arity => 0}], 'dot'._to_instance_method(Pwop)
    end
    
    def test_should_return_nil_for_nonexistent_method_on_module
      assert_nil 'foozle'._to_instance_method(Pwop)
    end
    
    def test_should_raise_argument_error_on_neither_class_nor_module
      assert_raise(ArgumentError) { 'foozle'._to_instance_method(Object.new) }
    end
    
  end
  
  class UNDERSCOREToMethod < Test::Unit::TestCase
    
    def test_should_return_expected_method_definition_for_existing_metaclass_method_on_class
      assert_method ['bar', {:arity => 0}], 'bar'._to_method(Foo)
    end
    
    def test_should_return_expected_method_definition_for_existing_class_method_on_class
      assert_method ['baz', {:arity => 0}], 'baz'._to_method(Foo)
    end
    
    def test_should_return_nil_for_existing_instance_method_on_class
      assert_nil 'bat'._to_method(Foo)
    end
    
    def test_should_return_nil_for_nonexistent_method_on_class
      assert_nil 'foozle'._to_method(Foo)
    end
    
    def test_should_return_expected_method_definition_for_existing_metaclass_method_on_module
      assert_method ['ding', {:arity => 0}], 'ding'._to_method(Pwop)
    end
    
    def test_should_return_expected_method_definition_for_existing_class_method_on_module
      assert_method ['dit', {:arity => 0}], 'dit'._to_method(Pwop)
    end
    
    def test_should_return_nil_for_existing_instance_method_on_module
      assert_nil 'dot'._to_method(Pwop)
    end
    
    def test_should_return_nil_for_nonexistent_method_on_module
      assert_nil 'foozle'._to_method(Pwop)
    end
    
  end
  
end

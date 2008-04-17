require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/sorted_methods_extension")
require 'test/unit'

class Trapeze::SortedInstanceMethodsExtensionTest < Test::Unit::TestCase
  
  class Foo
    
    def bar; end
    
    def baz; end
    
    def bat; end
    
    def pwop; end
    
    def ding; end
    
  end
  
  class Fizz < Foo
    
    def fuzz; end
    
    def doot; end
    
    def deet; end
    
    def dit; end
    
    def dot; end
    
  end
  
  def test_should_return_sorted_instance_methods_when_sent_UNDERSCOREinstance_methods_sorted_with_no_args
    actual = Fizz._instance_methods_sorted
    assert_equal Fizz.instance_methods.sort, actual
    assert_equal actual.sort, actual
    if Fizz.instance_methods == actual
      puts 'Note that on this platform the output of Module#instance_methods ' +
           'and Module#_instance_methods_sorted is the same for this test case.'
    end
  end
  
  def test_should_return_sorted_instance_methods_when_sent_UNDERSCOREinstance_methods_sorted_with_true
    actual = Fizz._instance_methods_sorted(true)
    assert_equal Fizz.instance_methods(true).sort, actual
    assert_equal actual.sort, actual
    if Fizz.instance_methods(true) == actual
      puts 'Note that on this platform the output of '                        +
           'Module#instance_methods(true) and '                               +
           'Module#_instance_methods_sorted(true) is the same for this test ' +
           'case.'
    end
  end
  
  def test_should_return_sorted_instance_methods_of_class_when_sent_UNDERSCOREinstance_methods_sorted_with_false
    actual = Fizz._instance_methods_sorted(false)
    assert_equal Fizz.instance_methods(false).sort, actual
    assert_equal actual.sort, actual
    if Fizz.instance_methods(false) == actual
      puts 'Note that on this platform the output of '                         +
           'Module#instance_methods(false) and '                               +
           'Module#_instance_methods_sorted(false) is the same for this test ' +
           'case.'
    end
  end
  
end

class Trapeze::SortedMethodsExtensionTest < Test::Unit::TestCase
  
  class Foo
    
    class << self
      
      def bar; end
      
      def baz; end
      
      def bat; end
      
      def pwop; end
      
      def ding; end
      
    end
    
  end
  
  class Fizz < Foo
    
    class << self
      
      def fuzz; end
      
      def doot; end
      
      def deet; end
      
      def dit; end
      
      def dot; end
      
    end
    
  end
  
  def test_should_return_sorted_methods_when_sent_UNDERSCOREmethods_sorted_with_no_args
    actual = Fizz._methods_sorted
    assert_equal Fizz.methods.sort, actual
    assert_equal actual.sort, actual
    if Fizz.methods == actual
      puts 'Note that on this platform the output of Object#methods and ' +
           'Object#_methods_sorted is the same for this test case.'
    end
  end
  
  def test_should_return_sorted_methods_when_sent_UNDERSCOREmethods_sorted_with_true
    actual = Fizz._methods_sorted(true)
    assert_equal Fizz.methods(true).sort, actual
    assert_equal actual.sort, actual
    if Fizz.methods(true) == actual
      puts 'Note that on this platform the output of Object#methods(true) ' +
           'and Object#_methods_sorted(true) is the same for this test case.'
    end
  end
  
  def test_should_return_sorted_methods_when_sent_UNDERSCOREmethods_sorted_with_false
    actual = Fizz._methods_sorted(false)
    assert_equal Fizz.methods(false).sort, actual
    assert_equal actual.sort, actual
    if Fizz.methods(false) == actual
      puts 'Note that on this platform the output of Object#methods(false) ' +
           'and Object#_methods_sorted(false) is the same for this test case.'
    end
  end
  
end

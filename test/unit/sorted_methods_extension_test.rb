require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/sorted_methods_extension")
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
  
  def test_should_return_sorted_instance_methods_when_sent_instance_methods_with_no_args
    actual = Fizz.instance_methods
    assert_equal Fizz.instance_methods_not_sorted.sort, actual
    assert_equal actual.sort, actual
    if Fizz.instance_methods_not_sorted == actual
      puts 'Note that on this platform the output of ' +
           'Module#instance_methods_not_sorted and ' +
           'Module#instance_methods_sorted is the same for this test case.'
    end
  end
  
  def test_should_return_sorted_instance_methods_when_sent_instance_methods_with_true
    actual = Fizz.instance_methods(true)
    assert_equal Fizz.instance_methods_not_sorted(true).sort, actual
    assert_equal actual.sort, actual
    if Fizz.instance_methods_not_sorted(true) == actual
      puts 'Note that on this platform the output of ' +
           'Module#instance_methods_not_sorted(true) and ' +
           'Module#instance_methods_sorted(true) is the same for this test ' +
           'case.'
    end
  end
  
  def test_should_return_sorted_instance_methods_of_class_when_sent_instance_methods_with_false
    actual = Fizz.instance_methods(false)
    assert_equal Fizz.instance_methods_not_sorted(false).sort, actual
    assert_equal actual.sort, actual
    if Fizz.instance_methods_not_sorted(false) == actual
      puts 'Note that on this platform the output of ' +
           'Module#instance_methods_not_sorted(false) and ' +
           'Module#instance_methods_sorted(false) is the same for this test ' +
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
  
  def test_should_return_sorted_methods_when_sent_methods_with_no_args
    actual = Fizz.methods
    assert_equal Fizz.methods_not_sorted.sort, actual
    assert_equal actual.sort, actual
    if Fizz.methods_not_sorted == actual
      puts 'Note that on this platform the output of ' +
           'Object#methods_not_sorted and Object#methods_sorted is the same ' +
           'for this test case.'
    end
  end
  
  def test_should_return_sorted_methods_when_sent_methods_with_true
    actual = Fizz.methods(true)
    assert_equal Fizz.methods_not_sorted(true).sort, actual
    assert_equal actual.sort, actual
    if Fizz.methods_not_sorted(true) == actual
      puts 'Note that on this platform the output of ' +
           'Object#methods_not_sorted(true) and Object#methods_sorted(true) ' +
           'is the same for this test case.'
    end
  end
  
  def test_should_return_sorted_methods_when_sent_methods_with_false
    actual = Fizz.methods(false)
    assert_equal Fizz.methods_not_sorted(false).sort, actual
    assert_equal actual.sort, actual
    if Fizz.methods_not_sorted(false) == actual
      puts 'Note that on this platform the output of ' +
           'Object#methods_not_sorted(false) and ' +
           'Object#methods_sorted(false) is the same for this test case.'
    end
  end
  
end

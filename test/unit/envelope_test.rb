require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/envelope")
require 'test/unit'

module Trapeze::EnvelopeTest
  
  class Klass < Test::Unit::TestCase
    
    def test_should_have_array_as_superclass
      assert_equal Array, Trapeze::Envelope.superclass
    end
    
    def test_should_define_no_class_methods
      assert_equal [], Trapeze::Envelope.methods(false)
    end
    
    def test_should_define_no_instance_methods
      assert_equal [], Trapeze::Envelope.instance_methods(false)
    end
    
  end
  
end

require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/instance_probe_result")
require 'test/unit'
require 'rubygems'
require 'mocha'
require File.expand_path("#{File.dirname __FILE__}/../assertion_helpers_extension")

module Trapeze::InstanceProbeResultTest
  
  class WithNoAttributes < Test::Unit::TestCase
    
    def setup
      @instance_probe_result = Trapeze::InstanceProbeResult.new
    end
    
    def test_should_return_nil_when_sent_instantiation
      assert_nil @instance_probe_result.instantiation
    end
    
    def test_should_return_empty_array_when_sent_probings
      assert_equal [], @instance_probe_result.probings
    end
    
  end
  
  class WithInstantiationAttribute < Test::Unit::TestCase
    
    def setup
      @instance_probe_result = Trapeze::InstanceProbeResult.new(:instantiation => 'foo')
    end
    
    def test_should_return_expected_instantiation_when_sent_instantiation
      assert_equal 'foo', @instance_probe_result.instantiation
    end
    
    def test_should_return_empty_array_when_sent_probings
      assert_equal [], @instance_probe_result.probings
    end
    
  end
  
  class WithProbingsAttribute < Test::Unit::TestCase
    
    def setup
      @instance_probe_result = Trapeze::InstanceProbeResult.new(:probings => 'foo')
    end
    
    def test_should_return_nil_when_sent_instantiation
      assert_nil @instance_probe_result.instantiation
    end
    
    def test_should_return_array_containing_expected_probing_when_sent_probings
      assert_equal ['foo'], @instance_probe_result.probings
    end
    
  end
  
  class WithUnexpectedAttribute < Test::Unit::TestCase
    
    def test_should_raise_argument_error
      assert_raise_message(ArgumentError, ':foo attribute unexpected') do
        Trapeze::InstanceProbeResult.new :foo => 'bar'
      end
    end
    
  end
  
  class WithInstantiationAttributeAndProbingsAttribute < Test::Unit::TestCase
    
    def setup
      @instance_probe_result = Trapeze::InstanceProbeResult.new(:instantiation => 'foo',
                                                                :probings => 'bar')
    end
    
    def test_should_return_expected_instantiation_when_sent_instantiation
      assert_equal 'foo', @instance_probe_result.instantiation
    end
    
    def test_should_return_array_containing_expected_probing_when_sent_probings
      assert_equal ['bar'], @instance_probe_result.probings
    end
    
  end
  
  module EQUALEQUAL
    
    class WithEquivalent < Test::Unit::TestCase
      
      def test_should_return_true
        a = Trapeze::InstanceProbeResult.new(:instantiation => 'foo',
                                             :probings => 'bar')
        b = Trapeze::InstanceProbeResult.new(:instantiation => 'foo',
                                             :probings => 'bar')
        assert_equal(true, (a == b))
      end
      
    end
    
    class WithDifferentClass < Test::Unit::TestCase
      
      def test_should_return_false
        instance_probe_result = Trapeze::InstanceProbeResult.new(:instantiation => 'foo')
        assert_equal(false, (instance_probe_result == :foo))
      end
      
    end
    
    class WithDifferentInstantiation < Test::Unit::TestCase
      
      def test_should_return_false
        a = Trapeze::InstanceProbeResult.new(:instantiation => 'foo',
                                             :probings => 'bar')
        b = Trapeze::InstanceProbeResult.new(:instantiation => 'baz',
                                             :probings => 'bar')
        assert_equal(false, (a == b))
      end
      
    end
    
    class WithDifferentProbings < Test::Unit::TestCase
      
      def test_should_return_false
        a = Trapeze::InstanceProbeResult.new(:instantiation => 'foo',
                                             :probings => 'bar')
        b = Trapeze::InstanceProbeResult.new(:instantiation => 'foo',
                                             :probings => 'baz')
        assert_equal(false, (a == b))
      end
      
    end
    
  end
  
end

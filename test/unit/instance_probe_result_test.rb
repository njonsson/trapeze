require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/instance_probe_result")
require 'test/unit'

module Trapeze::InstanceProbeResultTest
  
  class Empty < Test::Unit::TestCase
    
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
  
end

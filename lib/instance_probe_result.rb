# Defines Trapeze::InstanceProbeResult.

require File.expand_path("#{File.dirname __FILE__}/class_or_module_method_probe_result")
require File.expand_path("#{File.dirname __FILE__}/method_probe_result")

# Represents a series of calls to instance methods of a class or a module.
class Trapeze::InstanceProbeResult
  
  # Returns or sets:
  # * Either a Trapeze::ClassOrModuleMethodProbeResult representing a call to a
  #   class method for instantiating the object being probed
  # * Or a Module mixed into an object being probed
  attr_accessor :instantiation
  
  # Returns an array of Trapeze::MethodProbeResult objects representing calls to
  # instance methods of the object being probed.
  attr_reader :probings
  
  def initialize(attributes={})
    @instantiation = attributes.delete(:instantiation)
    @probings      = Array(attributes.delete(:probings))
    if (unexpected = attributes.keys.first)
      raise ArgumentError, ":#{unexpected} attribute unexpected"
    end
  end
  
  # Returns +true+ if _instance_probe_result_ has the same attributes.
  def ==(instance_probe_result)
    return false unless (self.class    == instance_probe_result.class)
    return false unless (instantiation == instance_probe_result.instantiation)
    return false unless (probings      == instance_probe_result.probings)
    true
  end
  
end

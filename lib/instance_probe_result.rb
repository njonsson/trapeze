# Defines Trapeze::InstanceProbeResult.

require File.expand_path("#{File.dirname __FILE__}/class_or_module_method_probe_result")
require File.expand_path("#{File.dirname __FILE__}/method_probe_result")

# Represents a series of calls to instance methods of a class or a module.
class Trapeze::InstanceProbeResult
  
  # Returns or sets a Trapeze::ClassOrModuleMethodProbeResult representing a
  # call to a class method for instantiating the object being probed.
  attr_accessor :instantiation
  
  # Returns an array of Trapeze::MethodProbeResult objects representing calls to
  # instance methods of the object being probed.
  attr_reader :probings
  
  def initialize
    @probings = []
  end
  
end

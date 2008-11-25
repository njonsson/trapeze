# Defines Trapeze::DefinedMethodsExtension.

# Adds methods to objects for obtaining the names of methods defined on them.
# 
# The names of these methods are prefixed with an underscore character in order
# to reduce the likelihood of method name collisions, given that the purpose of
# Trapeze is to load and analyze other Ruby programs.
# 
# These methods exist to be overridden on loaded types by Trapeze::Loader.
module Trapeze::DefinedInstanceMethodsExtension
  
  # Returns the value of Module#instance_methods.
  def _defined_instance_methods
    instance_methods
  end
  
end

module Trapeze::DefinedMethodsExtension
  
  # Returns the value of Object#methods.
  def _defined_methods
    methods
  end
  
end

Module.class_eval { include Trapeze::DefinedInstanceMethodsExtension }

Object.class_eval { include Trapeze::DefinedMethodsExtension }

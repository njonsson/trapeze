# Defines Trapeze::SortedInstanceMethodsExtension and
# Trapeze::SortedMethodsExtension.

# Adds an _instance_methods_sorted method to Module that returns the results of
# Module#instance_methods, sorted by name.
# 
# This mixin exists because Module#instance_methods has not proven to behave
# uniformly for all receivers.
# 
# The name of this method is prefixed with an underscore character in order to
# reduce the likelihood of method name collisions, given that the purpose of
# Trapeze is to load and analyze other Ruby programs.
module Trapeze::SortedInstanceMethodsExtension
  
  # Returns a sorted array containing the names of public instance methods in
  # the receiver. For a module, these are the public methods; for a class, they
  # are the instance (not singleton) methods. With no argument, or when
  # _include_super_ is +true+ the methods in the receiver and in its ancestors
  # are returned, otherwise the instance methods in the receiver are returned.
  def _instance_methods_sorted(include_super=true)
    instance_methods(include_super).sort
  end
  
end

# Adds a _methods_sorted method to Object that returns the results of
# Object#methods, sorted by name.
# 
# This mixin exists because Object#methods has not proven to behave uniformly
# for all receivers.
# 
# The name of this method is prefixed with an underscore character in order to
# reduce the likelihood of method name collisions, given that the purpose of
# Trapeze is to load and analyze other Ruby programs.
module Trapeze::SortedMethodsExtension
  
  # Returns a sorted array containing the names of methods publicly accessible
  # in the receiver. With no argument, or when _include_super_ is +true+, the
  # methods accessible to the receiver and to its type's ancestors are returned,
  # otherwise the methods accessible to the receiver are returned.
  def _methods_sorted(include_super=true)
    methods(include_super).sort
  end
  
end

Module.class_eval { include Trapeze::SortedInstanceMethodsExtension }

Object.class_eval { include Trapeze::SortedMethodsExtension }

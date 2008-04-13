# Defines Trapeze::SortedInstanceMethodsExtension and
# Trapeze::SortedMethodsExtension.

# Adds an implementation of the Module#instance_methods method that returns the
# names of methods sorted by name.
# 
# This mixin exists because Module#instance_methods has not proven to behave
# uniformly for all receivers.
module Trapeze::SortedInstanceMethodsExtension
  
  # Returns a sorted array containing the names of public instance methods in
  # the receiver. For a module, these are the public methods; for a class, they
  # are the instance (not singleton) methods. With no argument, or when
  # _include_super_ is +true+ the methods in the receiver and in its ancestors
  # are returned, otherwise the instance methods in the receiver are returned.
  def instance_methods_sorted(include_super=true)
    instance_methods_not_sorted(include_super).sort
  end
  
end

# Adds an implementation of the Object#methods method that returns the names of
# methods sorted by name.
# 
# This mixin exists because Object#methods has not proven to behave uniformly
# for all receivers.
module Trapeze::SortedMethodsExtension
  
  # Returns a sorted array containing the names of methods publicly accessible
  # in the receiver. With no argument, or when _include_super_ is +true+, the
  # methods accessible to the receiver and to its type's ancestors are returned,
  # otherwise the methods accessible to the receiver are returned.
  def methods_sorted(include_super=true)
    methods_not_sorted(include_super).sort
  end
  
end

Module.class_eval do
  alias_method :instance_methods_not_sorted, :instance_methods
  include Trapeze::SortedInstanceMethodsExtension
  alias_method :instance_methods, :instance_methods_sorted
end

Object.class_eval do
  alias_method :methods_not_sorted, :methods
  include Trapeze::SortedMethodsExtension
  alias_method :methods, :methods_sorted
end

# Defines Trapeze::Sandbox.

# Creates throwaway modules with predictable names for use as Loader sandboxes.
module Trapeze::Sandbox
  
  class << self
    
    # Returns a new module in the Trapeze namespace.
    def create
      begin
        unique = "Sandbox#{Kernel.rand 10000}"
      end while Trapeze.const_defined?(unique)
      Trapeze.const_set unique, Module.new
    end
    
    # Returns the name of _type_ but with
    # <strong>Trapeze::Sandbox<i>xxxx</i></strong> removed from the beginning of
    # it.
    def strip_from_type_name(type)
      type.name.gsub /^Trapeze::Sandbox\d+::/, ''
    end
    
  end
  
end

# Defines Trapeze::Sandbox.

# Creates throwaway modules with predictable names for use as Loader sandboxes.
module Trapeze::Sandbox
  
  class << self
    
    MESSAGE_PATTERN =  /Trapeze::Sandbox\d+::/
    TYPE_PATTERN    = /^Trapeze::Sandbox\d+::/
    
    # Returns a new module in the Trapeze namespace.
    def create
      begin
        unique = "Sandbox#{Kernel.rand 10000}"
      end while Trapeze.const_defined?(unique)
      Trapeze.const_set unique, Module.new
    end
    
    # Returns the _message_ but with <b>Trapeze::Sandbox<i>xxxx</i></b> removed
    # from it.
    def strip_from_message(message)
      message.gsub MESSAGE_PATTERN, ''
    end
    
    # Returns the name of _type_ but with <b>Trapeze::Sandbox<i>xxxx</i></b>
    # removed from the beginning of it.
    def strip_from_type_name(type)
      type.name.gsub TYPE_PATTERN, ''
    end
    
  end
  
end

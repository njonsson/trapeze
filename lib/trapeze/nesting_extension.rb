# Defines Trapeze::NestingExtension.

# Adds a <i>_nesting</i> class method to File that splits a file path into its
# constituent parts.
# 
# The name of this method is prefixed with an underscore character in order to
# reduce the likelihood of method name collisions, given that the purpose of
# Trapeze is to load and analyze other Ruby programs.
module Trapeze::NestingExtension
  
  module ClassMethods
    
    # Returns an array containing all the components of _path_.
    def _nesting(path)
      path.split /[\\\/]+/
    end
    
  end
  
  def self.included(other_module)
    other_module.extend ClassMethods
  end
  
end

File.class_eval { include Trapeze::NestingExtension }

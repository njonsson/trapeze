# Defines Trapeze::NestingExtension.

# Adds a _nesting_ class method to File that splits a file path into its
# constituent parts.
module Trapeze::NestingExtension
  
  module ClassMethods
    
    # Returns an array containing all the components of _path_.
    def nesting(path)
      path.split /[\\\/]+/
    end
    
  end
  
  def self.included(other_module)
    other_module.extend ClassMethods
  end
  
end

File.class_eval { include Trapeze::NestingExtension }

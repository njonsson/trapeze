# Defines Trapeze::ToMethodExtension.

# Adds methods to String objects for obtaining accordingly named Method objects.
# 
# The names of these methods are prefixed with an underscore character in order
# to reduce the likelihood of method name collisions, given that the purpose of
# Trapeze is to load and analyze other Ruby programs.
module Trapeze::ToMethodExtension
  
  # Returns the Method object for a String that represents an instance method on
  # _type_. Raises ArgumentError if _type_ is neither a Class nor a Module.
  def _to_instance_method(type)
    klass = case type.class.name
              when 'Class'
                type
              when 'Module'
                klass = Class.new
                klass.module_eval { include type }
                klass
              else
                raise ArgumentError,
                      'expected either a Class object or a Module object'
            end
    return nil unless type.instance_methods.include?(self)
    obj = klass.new
    obj.method self
  end
  
  # Returns the Method object for a String that represents a method on _obj_.
  def _to_method(obj)
    obj.method self
  rescue NameError
    nil
  end
  
end

String.class_eval { include Trapeze::ToMethodExtension }

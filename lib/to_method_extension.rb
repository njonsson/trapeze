# Defines Trapeze::ToMethodExtension.

# Adds a _to_instance_method_ and a _to_method_ method to String objects.
module Trapeze::ToMethodExtension
  
  # Returns the Method object for a String that represents an instance method on
  # _type_.
  def to_instance_method(type)
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
  def to_method(obj)
    obj.method self
  rescue NameError
    nil
  end
  
end

String.module_eval { include Trapeze::ToMethodExtension }

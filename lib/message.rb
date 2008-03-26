# Defines Trapeze::Message.

# Describes a call to a method.
class Trapeze::Message
  
  # The arguments passed to the method.
  attr_reader :args
  
  # The name of the method.
  attr_reader :method_name
  
  # A block passed to the method.
  attr_reader :block
  
  # The return value of the method.
  attr_reader :returned
  
  # Instantiates a new Trapeze::Message with the attributes supplied in
  # _attributes_. The _args_ attribute is converted to an array if it is not
  # already an array.
  def initialize(attributes={})
    unless attributes.include?(:method_name)
      raise ArgumentError, ':method_name attribute is required'
    end
    @method_name = attributes[:method_name]
    @args        = Array(attributes[:args])
    @block       = attributes[:block]
    @returned    = attributes[:returned]
  end
  
  # Returns +true+ if _message_ has the same attributes.
  def ==(message)
    return false unless (self.class  == message.class)
    return false unless (method_name == message.method_name)
    return false unless (args        == message.args)
    return false unless (block       == message.block)
    return false unless (returned    == message.returned)
    true
  end
  
  # Returns an array containing _args_ and _block_, if present.
  def args_and_block
    args + Array(block)
  end
  
end

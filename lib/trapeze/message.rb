# Defines Trapeze::Message.

# Represents a call to a method. The result of a Ruby method call is a returned
# object, a raised error or a thrown object.
# 
# Do not call Trapeze::Message.new -- call Trapeze::Message.returned,
# Trapeze::Message.raised or Trapeze::Message.thrown instead.
class Trapeze::Message
  
  class << self
    
    # Instantiates a Trapeze::Message with attributes specified in a hash of the
    # form: <tt>{:method_name => _string_, :args => _object_or_array_,
    # :block => _lambda_, :error => _exception_class_,
    # :error_message => _string_}</tt>.
    # 
    # The <tt>:args</tt> attribute is optional (defaults to <tt>[]</tt>). The
    # attributes <tt>:block</tt> and <tt>:error_message</tt> are also optional
    # (defaults to +nil+).
    def raised(attributes={})
      raise_if_unexpected attributes, :additional => [:error, :error_message]
      raise_unless_method_name attributes
      unless attributes[:error]
        raise ArgumentError, ":error attribute required"
      end
      
      raised = {:error => attributes.delete(:error)}
      if (error_message = attributes.delete(:error_message))
        raised[:message] = error_message
      end
      new attributes.merge(:reply => {:raised => raised})
    end
    
    # Instantiates a Trapeze::Message with attributes specified in a hash of the
    # form: <tt>{:method_name => _string_, :args => _object_or_array_,
    # :block => _lambda_, :returned => _object_}</tt>.
    # 
    # The attributes <tt>:block</tt> and <tt>:returned</tt> are optional
    # (defaults to +nil+).
    def returned(attributes={})
      raise_if_unexpected attributes, :additional => :returned
      raise_unless_method_name attributes
      
      returned = attributes.delete(:returned)
      new attributes.merge(:reply => {:returned => returned})
    end
    
    # Instantiates a Trapeze::Message with attributes specified in a hash of the
    # form: <tt>{:method_name => _string_, :args => _object_or_array_,
    # :block => _lambda_, :thrown => _object_}</tt>.
    # 
    # The attributes <tt>:block</tt> and <tt>:thrown</tt> are optional (defaults
    # to +nil+).
    def thrown(attributes={})
      raise_if_unexpected attributes, :additional => :thrown
      raise_unless_method_name attributes
      
      thrown = attributes.delete(:thrown)
      new attributes.merge(:reply => {:thrown => thrown})
    end
    
  private
    
    def allocate; end
    
    alias_method :new_without_args_conversion, :new
    def new_with_args_conversion(attributes)
      if attributes.include?(:args)
        if (args = attributes.delete(:args))
          attributes[:args] = Array(args)
        else
          attributes[:args] = [args]
        end
      end
      new_without_args_conversion attributes
    end
    alias_method :new, :new_with_args_conversion
    
    def raise_if_unexpected(attributes, options={})
      expected = [:method_name, :args, :block] + Array(options[:additional])
      attributes.keys.each do |a|
        unless expected.include?(a)
          raise ArgumentError, ":#{a} attribute unexpected"
        end
      end
    end
    
    def raise_unless_method_name(attributes)
      unless attributes[:method_name]
        raise ArgumentError, ":method_name attribute required"
      end
    end
    
  end
  
  # An array of arguments passed to _method_name_.
  attr_reader :args
  
  # The block passed to _method_name_.
  attr_reader :block
  
  # The name of the method being called.
  attr_reader :method_name
  
  # A hash representing the result of calling _method_name_. The hash takes one
  # of the following forms:
  # 
  # * <tt>{:returned => _object_}</tt>
  # * <tt>{:raised => {:error => _exception_class_, :message => _string_}</tt>
  # * <tt>{:thrown => _object_}</tt>
  attr_reader :reply
  
  def initialize(attributes)
    @args = []
    attributes.each { |attr, value| instance_variable_set "@#{attr}", value }
  end
  
  # Returns +true+ if _message_ has the same attributes.
  def ==(message)
    return false unless (self.class  == message.class)
    return false unless (method_name == message.method_name)
    return false unless (args        == message.args)
    return false unless (block       == message.block)
    return false unless (reply       == message.reply)
    true
  end
  
end

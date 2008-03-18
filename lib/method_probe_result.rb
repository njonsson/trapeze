# Defines Trapeze::MethodProbeResult.

# Represents a call to a method. The result of a Ruby method call is a returned
# object, a raised error or a thrown object.
# 
# Do not call Trapeze::MethodProbeResult.new -- call
# Trapeze::MethodProbeResult.returned, Trapeze::MethodProbeResult.raised or
# Trapeze::MethodProbeResult.thrown instead.
class Trapeze::MethodProbeResult
  
  class << self
    
    # Instantiates a Trapeze::MethodProbeResult with attributes specified in a
    # hash of the form: <tt>{:method_name => _string_,
    # :args => _object_or_array_, :block => _lambda_,
    # :error => _exception_class_, :error_message => _string_}</tt>.
    # 
    # The <tt>:args</tt> attribute is optional (assumed to be <tt>[]</tt>). The
    # attributes <tt>:block</tt> and <tt>:error_message</tt> are also optional
    # (assumed to be +nil+).
    def raised(attributes={})
      raise_if_unexpected attributes, :additional => [:error, :error_message]
      raise_unless_method_name attributes
      raise ArgumentError, ":error attribute required" unless attributes[:error]
      
      raised = {:error => attributes.delete(:error)}
      if (error_message = attributes.delete(:error_message))
        raised[:message] = error_message
      end
      new attributes.merge(:result => {:raised => raised})
    end
    
    # Instantiates a Trapeze::MethodProbeResult with attributes specified in a
    # hash of the form: <tt>{:method_name => _string_,
    # :args => _object_or_array_, :block => _lambda_,
    # :returned => _object_}</tt>.
    # 
    # The attributes <tt>:block</tt> and <tt>:returned</tt> are optional
    # (assumed to be +nil+).
    def returned(attributes={})
      raise_if_unexpected attributes, :additional => :returned
      raise_unless_method_name attributes
      
      returned = attributes.delete(:returned)
      new attributes.merge(:result => {:returned => returned})
    end
    
    # Instantiates a Trapeze::MethodProbeResult with attributes specified in a
    # hash of the form: <tt>{:method_name => _string_,
    # :args => _object_or_array_, :block => _lambda_, :thrown => _object_}</tt>.
    # 
    # The attributes <tt>:block</tt> and <tt>:thrown</tt> are optional (assumed
    # to be +nil+).
    def thrown(attributes={})
      raise_if_unexpected attributes, :additional => :thrown
      raise_unless_method_name attributes
      
      thrown = attributes.delete(:thrown)
      new attributes.merge(:result => {:thrown => thrown})
    end
    
  private
    
    def allocate; end
    
    alias_method :new_without_args_conversion, :new
    def new(attributes)
      if attributes.include?(:args)
        if (args = attributes.delete(:args))
          attributes[:args] = Array(args)
        else
          attributes[:args] = [args]
        end
      end
      new_without_args_conversion attributes
    end
    
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
  
  # Returns an array of arguments passed to the method being probed.
  attr_reader :args
  
  # Returns the block passed to the method being probed.
  attr_reader :block
  
  # Returns the name of the method being probed.
  attr_reader :method_name
  
  # Returns a hash representing the result of calling the method being probed.
  # The hash takes one of the following forms:
  # 
  # * <tt>{:returned => _object_}</tt>
  # * <tt>{:raised => {:error => _exception_class_, :message => _string_}</tt>
  # * <tt>{:thrown => _object_}</tt>
  attr_reader :result
  
  def initialize(attributes)
    @args = []
    attributes.each { |attr, value| instance_variable_set "@#{attr}", value }
  end
  
  # Returns +true+ if _other_ is of the same class and has the same attributes.
  def ==(other)
    return false unless (self.class  == other.class)
    return false unless (method_name == other.method_name)
    return false unless (args        == other.args)
    return false unless (block.nil?  == other.block.nil?)
    return false unless (block.call  == other.block.call)
    result == other.result
  end
  
end

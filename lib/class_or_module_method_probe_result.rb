# Defines Trapeze::ClassOrModuleMethodProbeResult.

require File.expand_path("#{File.dirname __FILE__}/method_probe_result")

# Represents a call to a class method of a class or a module method of a module.
# The result of a Ruby method call is a returned object, a raised error or a
# thrown object.
# 
# Do not call Trapeze::ClassOrModuleMethodProbeResult.new -- call
# Trapeze::ClassOrModuleMethodProbeResult.returned,
# Trapeze::ClassOrModuleMethodProbeResult.raised or
# Trapeze::ClassOrModuleMethodProbeResult.thrown instead.
class Trapeze::ClassOrModuleMethodProbeResult < Trapeze::MethodProbeResult
  
  class << self
    
    # Instantiates a Trapeze::ClassOrModuleMethodProbeResult with attributes
    # specified in a hash of the form:
    # <tt>{:class_or_module => _class_or_module_, :method_name => _string_,
    # :args => _object_or_array_, :block => _lambda_,
    # :error => _exception_class_, :error_message => _string_}</tt>.
    # 
    # The <tt>:args</tt> attribute is optional (assumed to be <tt>[]</tt>). The
    # attributes <tt>:block</tt> and <tt>:error_message</tt> are also optional
    # (assumed to be +nil+).
    def raised(attributes={})
      raise_if_unexpected attributes, :additional => [:error, :error_message]
      raise_unless_class_or_module_and_method_name attributes
      raise ArgumentError, ":error attribute required" unless attributes[:error]
      
      raised = {:error => attributes.delete(:error)}
      if (error_message = attributes.delete(:error_message))
        raised[:message] = error_message
      end
      new attributes.merge(:result => {:raised => raised})
    end
    
    # Instantiates a Trapeze::ClassOrModuleMethodProbeResult with attributes
    # specified in a hash of the form:
    # <tt>{:class_or_module => _class_or_module_, :method_name => _string_,
    # :args => _object_or_array_, :block => _lambda_,
    # :returned => _object_}</tt>.
    # 
    # The attributes <tt>:block</tt> and <tt>:returned</tt> are optional
    # (assumed to be +nil+).
    def returned(attributes={})
      raise_if_unexpected attributes, :additional => :returned
      raise_unless_class_or_module_and_method_name attributes
      
      returned = attributes.delete(:returned)
      new attributes.merge(:result => {:returned => returned})
    end
    
    # Instantiates a Trapeze::ClassOrModuleMethodProbeResult with attributes
    # specified in a hash of the form:
    # <tt>{:class_or_module => _class_or_module_, :method_name => _string_,
    # :args => _object_or_array_, :block => _lambda_, :thrown => _object_}</tt>.
    # 
    # The attributes <tt>:block</tt> and <tt>:thrown</tt> are optional (assumed
    # to be +nil+).
    def thrown(attributes={})
      raise_if_unexpected attributes, :additional => :thrown
      raise_unless_class_or_module_and_method_name attributes
      
      thrown = attributes.delete(:thrown)
      new attributes.merge(:result => {:thrown => thrown})
    end
    
  private
    
    alias_method :raise_if_unexpected_without_class_or_module,
                 :raise_if_unexpected
    def raise_if_unexpected(attributes, options={})
      additional = Array(options[:additional])
      additional << :class_or_module
      raise_if_unexpected_without_class_or_module attributes,
                                                  options.merge(:additional => additional)
    end
    
    def raise_unless_class_or_module_and_method_name(attributes)
      unless attributes[:class_or_module]
        raise ArgumentError, ":class_or_module attribute required"
      end
      unless attributes[:method_name]
        raise ArgumentError, ":method_name attribute required"
      end
    end
    
  end
  
  # Returns the defining class of the class method or module of the module
  # method being probed.
  attr_reader :class_or_module
  
  def initialize(attributes)
    @class_or_module = attributes.delete(:class_or_module)
    super
  end
  
  # Returns +true+ if _class_or_module_method_probe_result_ has the same
  # attributes.
  def ==(class_or_module_method_probe_result)
    return false unless super(class_or_module_method_probe_result)
    return false unless (class_or_module ==
                         class_or_module_method_probe_result.class_or_module)
    true
  end
  
end

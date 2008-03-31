# Defines Trapeze::Probes::BasicProbe.

require File.expand_path("#{File.dirname __FILE__}/../class_or_module_method_probe_result")
require File.expand_path("#{File.dirname __FILE__}/../courier")
require File.expand_path("#{File.dirname __FILE__}/../instance_probe_result")
require File.expand_path("#{File.dirname __FILE__}/../method_probe_result")
require File.expand_path("#{File.dirname __FILE__}/../probes")
require File.expand_path("#{File.dirname __FILE__}/../to_method_extension")

# Explores the source code contained in _loader_ in order to discover its
# behavior.
class Trapeze::Probes::BasicProbe
  
  class << self
    
    def probe_method(method) #:nodoc:
      args = (1..method.arity.abs).collect { |i| Trapeze::Courier.new }
      returned = method.call(*args)
      
      args.collect! do |a|
#        begin
          a.__seal_envelope__
#        rescue NoMethodError
#          a
#        end
      end
      
      begin
        returned = returned.__seal_envelope__
      rescue NoMethodError
      end
      
      {:args => args, :returned => returned}
    end
    
  end
  
  # The Trapeze::Loader object used to drive the probe.
  attr_reader :loader
  
  # Instantiates a new Trapeze::Probes::BasicProbe with the specified
  # Trapeze::Loader.
  def initialize(loader)
    @loader = loader
  end
  
  def probe!
    @results = []
    probe_class_definitions!
    probe_module_definitions!
    probe_method_definitions!
    self
  end
  
  def results
    probe! unless @results
    @results
  end
  
private
  
  def probe_class_definitions!
    @loader.class_definitions.each do |c|
      probe_class_methods_for_class! c
      probe_instance_methods_for_class! c
    end
    self
  end
  
  def probe_class_methods_for_class!(klass)
    (klass.methods - Class.methods).each do |m|
      result = self.class.probe_method(m.to_method(klass))
      @results << Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => klass,
                                                                   :method_name => m,
                                                                   :args => result[:args],
                                                                   :returned => result[:returned])
    end
    self
  end
  
  def probe_instance_methods_for_class!(klass)
    instance_methods = (klass.instance_methods - Object.instance_methods)
    return self if instance_methods.empty?
    
    instance = klass.new
    instantiation = Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => klass,
                                                                     :method_name => 'new')
    instance_probe_result = Trapeze::InstanceProbeResult.new(:instantiation => instantiation)
    instance_methods.each do |m|
      result = self.class.probe_method(m.to_method(instance))
      instance_probe_result.probings << Trapeze::MethodProbeResult.returned(:method_name => m,
                                                                            :args => result[:args],
                                                                            :returned => result[:returned])
    end
    @results << instance_probe_result
    self
  end
  
  def probe_instance_methods_for_module!(mod)
    instance_methods = (mod.instance_methods - Object.instance_methods)
    return self if instance_methods.empty?
    
    klass = Class.new
    klass.instance_eval { include mod }
    instance = klass.new
    instance_probe_result = Trapeze::InstanceProbeResult.new(:instantiation => mod)
    instance_methods.each do |m|
      result = self.class.probe_method(m.to_method(instance))
      instance_probe_result.probings << Trapeze::MethodProbeResult.returned(:method_name => m,
                                                                            :args => result[:args],
                                                                            :returned => result[:returned])
    end
    @results << instance_probe_result
    self
  end
  
  def probe_method_definitions!
    @loader.method_definitions.each do |m|
      result = self.class.probe_method(m)
      @results << Trapeze::MethodProbeResult.returned(:method_name => m.name,
                                                      :args => result[:args],
                                                      :returned => result[:returned])
    end
    self
  end
  
  def probe_module_definitions!
    @loader.module_definitions.each do |mod|
      probe_module_methods_for_module! mod
      probe_instance_methods_for_module! mod
    end
    self
  end
  
  def probe_module_methods_for_module!(mod)
    (mod.methods - Module.methods).each do |m|
      result = self.class.probe_method(m.to_method(mod))
      @results << Trapeze::ClassOrModuleMethodProbeResult.returned(:class_or_module => mod,
                                                                   :method_name => m,
                                                                   :args => result[:args],
                                                                   :returned => result[:returned])
    end
    self
  end
  
end

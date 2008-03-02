# Defines Trapeze::Probes::StandardProbe.

require File.expand_path("#{File.dirname __FILE__}/../probes")
require File.expand_path("#{File.dirname __FILE__}/../courier")
require File.expand_path("#{File.dirname __FILE__}/../to_method_extension")

# Explores the source code contained in _loader_ in order to discover its
# behavior.
class Trapeze::Probes::StandardProbe
  
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
  
  # Instantiates a new Trapeze::Probes::StandardProbe with the specified
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
      (c.methods - Class.methods).each do |m|
        result = self.class.probe_method(m.to_method(c))
        @results << result.merge({:class => c, :class_method => m})
      end
      (c.instance_methods - Object.instance_methods).each do |m|
        result = self.class.probe_method(m.to_instance_method(c))
        @results << result.merge({:class => c, :instance_method => m})
      end
    end
    self
  end
  
  def probe_method_definitions!
    @loader.method_definitions.each do |m|
      result = self.class.probe_method(m)
      @results << result.merge({:method => m.name})
    end
    self
  end
  
  def probe_module_definitions!
    @loader.module_definitions.each do |mod|
      (mod.methods - Module.methods).each do |m|
        result = self.class.probe_method(m.to_method(mod))
        @results << result.merge({:module => mod, :class_method => m})
      end
      (mod.instance_methods - Object.instance_methods).each do |m|
        result = self.class.probe_method(m.to_instance_method(mod))
        @results << result.merge({:module => mod, :instance_method => m})
      end
    end
    self
  end
  
end

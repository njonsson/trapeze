# Defines Trapeze::Probe.

require File.expand_path("#{File.dirname __FILE__}/courier")
require File.expand_path("#{File.dirname __FILE__}/defined_methods_extension")
require File.expand_path("#{File.dirname __FILE__}/to_method_extension")

# Explores the source code contained in _loader_ in order to discover its
# behavior.
class Trapeze::Probe
  
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
  
  # Instantiates a new Trapeze::Probe with the specified Trapeze::Loader.
  def initialize(loader)
    @loader = loader
  end
  
  # Returns the results of probing classes in _loader_, calling probe! if they
  # have not been obtained already. Results are supplied in an array of hashes
  # of the form: <tt>{:class => _class_,
  # :class_method_probings => _array_of_Message_objects_,
  # :instantiation => _Message_,
  # :instance_method_probings => _array_of_Message_objects_}</tt>.
  def class_probe_results
    probe_or_get_results :class
  end
  
  # Returns the results of probing modules in _loader_, calling probe! if they
  # have not been obtained already. Results are supplied in an array of hashes
  # of the form: <tt>{:module => _module_,
  # :module_method_probings => _array_of_Message_objects_,
  # :instance_method_probings => _array_of_Message_objects_}</tt>.
  def module_probe_results
    probe_or_get_results :module
  end
  
  # Analyzes the contents of _loader_, populating class_probe_results,
  # module_probe_results and top_level_method_probe_results.
  def probe!
    @results = {}
    probe_classes!
    probe_modules!
    probe_top_level_methods!
    self
  end
  
  # Returns the results of probing top-level methods in _loader_, calling probe!
  # if they have not been obtained already. Results are supplied in an array of
  # Message objects.
  def top_level_method_probe_results
    probe_or_get_results :top_level_method
  end
  
private
  
  def probe_or_get_results(type)
    probe! unless @results
    @results["#{type}_probe_results".to_sym]
  end
  
  def probe_classes!
    class_probe_results = (@results[:class_probe_results] = [])
    @loader.classes.each do |c|
      class_probe_results << {:class => c}
      probe_class_methods_for_class! c
      probe_instance_methods_for_class! c
    end
    self
  end
  
  def probe_class_methods_for_class!(klass)
    class_method_probings = (@results[:class_probe_results].last[:class_method_probings] = [])
    return false if klass._defined_methods.empty?
    
    klass._defined_methods.each do |m|
      reply = self.class.probe_method(m._to_method(klass))
      class_method_probings << {:method_name => m,
                                :args => reply[:args],
                                :returned => reply[:returned]}
    end
    self
  end
  
  def probe_top_level_methods!
    top_level_method_probe_results = (@results[:top_level_method_probe_results] = [])
    @loader.top_level_methods.each do |m|
      reply = self.class.probe_method(m._to_method(Object))
      top_level_method_probe_results << {:method_name => m,
                                         :args => reply[:args],
                                         :returned => reply[:returned]}
    end
    self
  end
  
  def probe_instance_methods_for_class!(klass)
    class_probe_results = @results[:class_probe_results]
    instance_method_probings = (class_probe_results.last[:instance_method_probings] = [])
    return false if klass._defined_instance_methods.empty?
    
    instance = klass.new
    class_probe_results.last[:instantiation] = {:method_name => 'new',
                                                :returned => instance}
    klass._defined_instance_methods.each do |m|
      reply = self.class.probe_method(m._to_method(instance))
      instance_method_probings << {:method_name => m,
                                   :args => reply[:args],
                                   :returned => reply[:returned]}
    end
    self
  end
  
  def probe_instance_methods_for_module!(mod)
    instance_method_probings = (@results[:module_probe_results].last[:instance_method_probings] = [])
    return false if mod._defined_instance_methods.empty?
    
    klass = Class.new
    klass.class_eval { include mod }
    instance = klass.new
    mod._defined_instance_methods.each do |m|
      reply = self.class.probe_method(m._to_method(instance))
      instance_method_probings << {:method_name => m,
                                   :args => reply[:args],
                                   :returned => reply[:returned]}
    end
    self
  end
  
  def probe_modules!
    module_probe_results = (@results[:module_probe_results] = [])
    @loader.modules.each do |m|
      module_probe_results << {:module => m}
      probe_module_methods_for_module! m
      probe_instance_methods_for_module! m
    end
    self
  end
  
  def probe_module_methods_for_module!(mod)
    module_method_probings = (@results[:module_probe_results].last[:module_method_probings] = [])
    return false if mod._defined_methods.empty?
    
    mod._defined_methods.each do |m|
      reply = self.class.probe_method(m._to_method(mod))
      module_method_probings << {:method_name => m,
                                 :args => reply[:args],
                                 :returned => reply[:returned]}
    end
    self
  end
  
end

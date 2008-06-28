# Defines Trapeze::Loader.

require File.expand_path("#{File.dirname __FILE__}/defined_methods_extension")

# Loads source code files and retrieves class, module and top-level method
# definitions contained within them.
# 
# Note that source code is loaded in the current Ruby process. Changes to the
# behavior of core Ruby types may take effect as a result.
class Trapeze::Loader
  
  # The paths of source code files to load.
  attr_reader :filenames
  
  # Instantiates a new Trapeze::Loader with the source code files supplied in
  # _filenames_.
  def initialize(*filenames)
    @filenames = filenames
  end
  
  # Returns classes defined in _filenames_, calling load! if it has not been
  # called already.
  # 
  # The return value is an array of Class objects with <i>_defined_methods</i>
  # and <i>_defined_instance_methods</i> attributes containing the names of
  # methods defined in the source code files.
  # 
  # The class methods and instance methods indicated do not include inherited
  # methods.
  def classes
    load_and_get! :classes
  end
  
  # Returns information about exceptions raised while loading _filenames_,
  # calling load! if it has not been called already.
  # 
  # The return value is an array of arrays of the form:
  # <tt>[_filename_, _exception_]</tt>.
  def exceptions
    load_and_get! :exceptions
  end
  
  # Loads the source code files supplied in _filenames_ and retrieves
  # information about the classes, modules and top-level methods defined in
  # them, as well as exceptions that occur during loading. Returns +false+ if
  # the information has already been retrieved.
  def load!
    return false if @loaded
    @loaded = sandbox_all_and_extract
    unsandbox_all!
    map_all!
    self
  end
  
  # Returns modules defined in _filenames_, calling load! if it has not been
  # called already.
  # 
  # The return value is an array of Module objects with <i>_defined_methods</i>
  # and <i>_defined_instance_methods</i> attributes containing the names of
  # methods defined in the source code files.
  # 
  # The module methods and instance methods indicated do not include inherited
  # methods.
  def modules
    load_and_get! :modules
  end
  
  # Returns the names of top-level methods defined in _filenames_, calling load!
  # if it has not been called already.
  def top_level_methods
    load_and_get! :top_level_methods
  end
  
private
  
  def constantize(type_name)
    Object.instance_eval type_name
  end
  
  def extract_all(sandbox)
    classes, modules = extract_classes_and_modules(sandbox)
    {:classes => classes,
     :modules => modules,
     :top_level_methods => extract_top_level_methods(sandbox)}
  end
  
  def extract_classes_and_modules(sandbox)
    classes, modules = [], []
    sandbox.constants.each do |c|
      sandboxed_type = sandbox.module_eval(c)
      sandboxed_metaclass = sandboxed_type.instance_eval do
        class << self
          self
        end
      end
      sandboxed_metaclass.class_eval do
        defined_methods = (sandboxed_type.methods -
                           sandboxed_type.class.methods).sort
        define_method :_defined_methods do
          defined_methods
        end
        defined_instance_methods = (sandboxed_type.instance_methods -
                                    Object.instance_methods).sort
        define_method :_defined_instance_methods do
          defined_instance_methods
        end
      end
      if sandboxed_type.class == Class
        classes << sandboxed_type
      elsif sandboxed_type.class == Module
        modules << sandboxed_type
      else
        raise 'every type is expected to be either a Class or a Module'
      end
    end
    [classes, modules]
  end
  
  def extract_top_level_methods(sandbox)
    ((sandbox.methods - Module.methods) +
     (sandbox.instance_methods - Object.instance_methods)).uniq.sort
  end
  
  def load_and_get!(attr)
    load!
    @loaded[attr]
  end
  
  def map_all!
    map = lambda do |sandboxed_type|
      type_name = sandboxed_type.name.gsub(/^.+?::/, '')
      type = constantize(type_name)
      metaclass = type.instance_eval do
        class << self
          self
        end
      end
      metaclass.class_eval do
        define_method :_defined_methods do
          sandboxed_type._defined_methods
        end
        define_method :_defined_instance_methods do
          sandboxed_type._defined_instance_methods
        end
      end
      type
    end
    @loaded[:classes].collect! &map
    @loaded[:modules].collect! &map
    self
  end
  
  def sandbox_all_and_extract
    sandbox = Module.new
    exceptions = @filenames.inject([]) do |result, filename|
      begin
        sandbox.module_eval File.read(filename)
      rescue Exception => e
        result << [filename, e]
      end
      result
    end
    extract_all(sandbox).merge :exceptions => exceptions
  end
  
  def unsandbox!(source_filename)
    load source_filename
  end
  
  def unsandbox_all!
    @filenames.each do |f|
      begin
        unsandbox! f
      rescue Exception
      end
    end
    self
  end
  
end

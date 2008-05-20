# Defines Trapeze::Loader.

require File.expand_path("#{File.dirname __FILE__}/sandbox")
require File.expand_path("#{File.dirname __FILE__}/to_method_extension")

# Loads source code files and retrieves Class, Module and Method definitions
# contained within them.
class Trapeze::Loader
  
  # The paths of source code files to load.
  attr_reader :filenames
  
  # Instantiates a new Trapeze::Loader with the source code files supplied in
  # _filenames_.
  def initialize(*filenames)
    @filenames = filenames
  end
  
  # Returns Class definitions present in _filenames_, calling load! if it has
  # not been called already.
  def class_definitions
    load_or_get! :class_definitions
  end
  
  # Returns exceptions raised while loading _filenames_, calling load! if it has
  # not been called already.
  def exceptions
    load_or_get! :exceptions
  end
  
  # Loads the source code files supplied in _filenames_ and retrieves Class,
  # Module and Method definitions from them.
  def load!
    sandbox = Trapeze::Sandbox.create
    exceptions = @filenames.inject([]) do |exceptions, filename|
      begin
        sandbox.module_eval File.read(filename)
      rescue Exception => e
        exceptions << [filename, e]
      end
      exceptions
    end
    @loaded = extract_definitions(sandbox).merge(:exceptions => exceptions)
    self
  end
  
  # Returns Method definitions present in _filenames_, calling load! if it has
  # not been called already.
  def method_definitions
    load_or_get! :method_definitions
  end
  
  # Returns Module definitions present in _filenames_, calling load! if it has
  # not been called already.
  def module_definitions
    load_or_get! :module_definitions
  end
  
private
  
  def extract_class_definitions_and_module_definitions(sandbox)
    classes, modules = [], []
    sandbox.constants.each do |c|
      constant = sandbox.module_eval(c)
      case constant.class.name
        when 'Class'
          classes << constant
        when 'Module'
          modules << constant
      end
    end
    [classes, modules]
  end
  
  def extract_definitions(sandbox)
    classes, modules = extract_class_definitions_and_module_definitions(sandbox)
    {:class_definitions => classes,
     :module_definitions => modules,
     :method_definitions => extract_method_definitions(sandbox)}
  end
  
  def extract_method_definitions(sandbox)
    sandbox.instance_methods.sort.collect do |m|
      m._to_instance_method sandbox
    end
  end
  
  def load_or_get!(attr)
    load! unless @loaded
    @loaded[attr]
  end
  
end

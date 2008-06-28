# Defines Trapeze::SuiteGenerators::Base.

require 'erb'
require 'fileutils'
require File.expand_path("#{File.dirname __FILE__}/../inflections_extension")
require File.expand_path("#{File.dirname __FILE__}/../string_matcher")
require File.expand_path("#{File.dirname __FILE__}/../suite_generators")

# The base class for library-specific generators in Trapeze::SuiteGenerators.
class Trapeze::SuiteGenerators::Base
  
  class << self
    
    def allocate #:nodoc:
      raise_unless_inherited
      super
    end
    
  private
    
    def raise_unless_inherited
      if self == Trapeze::SuiteGenerators::Base
        raise RuntimeError, "#{self} is an abstract class"
      end
      self
    end
    
  end
  
  # The Dir.glob pattern used to find source files being analyzed.
  attr_reader :input_files_pattern
  
  # The directory in which generated files will be created.
  attr_reader :output_dir
  
  # The Trapeze::Probe object from which a suite will be generated.
  attr_reader :probe
  
  # (Not to be called directly because Trapeze::SuiteGenerators::Base
  # is an abstract class.)
  def initialize(attributes={})
    self.class.send :raise_unless_inherited
    raise_unless_input_files_pattern attributes
    raise_unless_output_dir attributes
    raise_if_output_dir_is_a_file attributes
    raise_unless_probe attributes
    
    attributes.each do |attr, value|
      instance_variable_set "@#{attr}", value
    end
  end
  
  # Clobbers _output_dir_ and generates a suite of test cases or specifications
  # described by _probe_ for the source files of _input_files_pattern_.
  def generate!
    clobber_dir! output_dir
    
    generate_suite_file!
    generate_class_files!
    generate_module_files!
    generate_top_level_methods_file!
    
    self
  end
  
private
  
  def clobber_dir!(dir)
    FileUtils.rm_rf(output_dir) if File.exist?(output_dir)
    FileUtils.mkdir_p output_dir
  end
  
  def create_erb(template_source)
    ERB.new template_source, nil, '-'
  end
  
  def find_template_or_partial(name)
    base_dir = File.expand_path(File.dirname(__FILE__))
    generator_dir = "#{base_dir}/#{generator_bare_name._pathify}"
    filename = "#{generator_dir}/templates/#{name}.rb.erb"
    if template_or_partial_exist?(filename)
      return filename
    end
    filename = "#{base_dir}/shared_templates/#{name}.rb.erb"
    if template_or_partial_exist?(filename)
      return filename
    end
    nil
  end
  
  def forward_missing_methods_to_me(obj, options={})
    me, locals = self, options[:locals]
    singleton_class = class << obj; self; end
    singleton_class.send(:define_method, :method_missing) do |method, *args|
      return locals[method] if locals && locals.include?(method)
      me.send method, *args
    end
    self
  end
  
  def forwardable_binding_for(obj, options={})
    binding_obj = obj.instance_eval('binding')
    forward_missing_methods_to_me obj, options
    binding_obj
  end
  
  def generate_class_files!
    probe.class_probe_results.each do |r|
      class_name = r[:class].name
      target = target_for('class', :class_name => class_name)
      render :template => 'class',
             :target => target,
             :object => r,
             :locals => {:class_name => class_name.split('::').last}
    end
    self
  end
  
  def generate_module_files!
    probe.module_probe_results.each do |r|
      module_name = r[:module].name
      target = target_for('module', :module_name => module_name)
      render :template => 'module',
             :target => target,
             :object => r,
             :locals => {:module_name => module_name.split('::').last}
    end
    self
  end
  
  def generate_suite_file!
    render :template => 'SUITE'
  end
  
  def generate_top_level_methods_file!
    return self if probe.top_level_method_probe_results.empty?
    target = target_for('top_level_methods')
    render :template => 'top_level_methods', :target => target
  end
  
  def generator_bare_name
    base_name      = Trapeze::SuiteGenerators::Base.name
    generator_name = self.class.name
    (generator_name.split('::') - base_name.split('::')).join '::'
  end
  
  def output_dir_file?(output_dir)
    File.file? output_dir
  end
  
  def raise_if_output_dir_is_a_file(attributes)
    if output_dir_file?(attributes[:output_dir])
      raise ArgumentError, ':output_dir attribute must not be a file'
    end
    self
  end
  
  %w(input_files_pattern output_dir probe).each do |attribute_name|
    define_method "raise_unless_#{attribute_name}" do |attributes|
      unless attributes[attribute_name.to_sym]
        raise ArgumentError, ":#{attribute_name} attribute required"
      end
      self
    end
  end
  
  def relative_path_to_input_files_pattern
    input_dirs  = input_files_pattern.split(/[\\\/]+/)
    output_dirs = output_dir.split(/[\\\/]+/)
    min = [input_dirs.length, output_dirs.length].min
    first_different_dir_index = (0..min).detect do |i|
      input_dirs[0..i] != output_dirs[0..i]
    end
    common_dirs = input_dirs[first_different_dir_index..-1]
    up_dirs = ['..'] * (output_dirs.length - first_different_dir_index)
    (up_dirs + common_dirs).join '/'
  end
  
  def render(options={})
    template, partial = options.delete(:template), options.delete(:partial)
    if template && ! partial
      render_template template, options
    elsif ! template && partial
      render_partial partial, options
    else
      raise ArgumentError,
            'either the :template option or the :partial option is required, ' +
            'but not both'
    end
  end
  
  def render_partial(partial, options={})
    unless (partial_filename = find_template_or_partial("_#{partial}"))
      raise ArgumentError, "could not find partial template '#{partial}'"
    end
    obj, collection = options.delete(:object), options.delete(:collection)
    if obj && ! collection
      partial_source = File.read(partial_filename)
      create_erb(partial_source).result forwardable_binding_for(obj, options)
    elsif ! obj && collection
      results = collection.collect do |o|
        render_partial partial, options.merge(:object => o)
      end
      results.join
    elsif obj && collection
      raise ArgumentError,
            'the :object option and the :collection option are mutually ' +
            'exclusive'
    else
      create_erb(File.read(partial_filename)).result
    end
  end
  
  def render_template(template, options={})
    obj, target = options.delete(:object), options.delete(:target)
    unless (template_filename = find_template_or_partial(template))
      raise ArgumentError, "could not find template '#{template}'"
    end
    target_filename = "#{output_dir}/#{target || template}.rb"
    erb = create_erb(File.read(template_filename))
    File.open(target_filename, 'w+') do |target_file|
      binding_obj = obj ? forwardable_binding_for(obj, options) : binding
      target_file.print erb.result(binding_obj)
    end
    self
  end
  
  def template_or_partial_exist?(filename)
    File.exist? filename
  end
  
end

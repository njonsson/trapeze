require File.expand_path("#{File.dirname __FILE__}/test")
require File.expand_path("#{File.dirname __FILE__}/../lib/trapeze/application")
require File.expand_path("#{File.dirname __FILE__}/../lib/trapeze/inflections_extension")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/assertion_helpers_extension")
require 'fileutils'

system_test_dirs = []
system_tests_dir = "#{File.dirname __FILE__}/system"
Dir.glob("#{system_tests_dir}/**/{input,output_truth}") do |d|
  system_test_dirs << d.gsub(/\/(input|output_truth)$/, '')
end
system_test_dirs.uniq!

def define_nested_class(class_full_name)
  nesting = class_full_name.split('::')
  module_names = nesting[0...-1]
  class_name = nesting.last
  mod = module_names.inject(nil) do |parent_module, module_name|
    parent_module ||= Object
    unless parent_module.const_defined?(module_name)
      parent_module.const_set module_name, Module.new
    end
    parent_module.const_get module_name
  end
  yield mod.const_set(class_name, Class.new(Test::Unit::TestCase))
end

system_tests_dir_regexp = Regexp.new("^#{Regexp.escape system_tests_dir}/")
system_test_dirs.each do |d|
  relative_dir = d.gsub(system_tests_dir_regexp, '')
  define_nested_class("Trapeze::SystemTest::#{relative_dir._typify}") do |c|
    c.send(:define_method, :test_should_generate_expected_output) do
      input_files_pattern = File.expand_path("#{d}/input/**/*.rb")
      output_dir          = File.expand_path("#{d}/output")
      output_truth_dir    = File.expand_path("#{d}/output_truth")
      FileUtils.rm_rf(output_dir) if File.exist?(output_dir)
      FileUtils.mkdir_p output_dir
      application = Trapeze::Application.new('--input-files-pattern',
                                             input_files_pattern,
                                             '--output-dir',
                                             output_dir)
      application.run!
      assert_dirs_identical output_truth_dir, output_dir
    end
  end
end

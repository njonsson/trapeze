require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/application")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/loader")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/probe")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/suite_generators/test_unit")
require 'test/unit'
require 'rubygems'
require 'mocha'
require File.expand_path("#{File.dirname __FILE__}/../assertion_helpers_extension")

module Trapeze::ApplicationTest
  
  module New
    
    class WithNoArgs < Test::Unit::TestCase
      
      def test_should_not_print_to_stderr
        $stderr.expects(:puts).never
        Trapeze::Application.new
      end
      
      def test_should_not_print_to_stdout
        $stdout.expects(:puts).never
        Trapeze::Application.new
      end
      
      def test_should_not_call_kernel_exit
        Kernel.expects(:exit).never
        Trapeze::Application.new
      end
      
    end
    
    class WithInvalidOption < Test::Unit::TestCase
      
      def setup
        $stderr.stubs :puts
        $stdout.stubs :puts
        Kernel.stubs :exit
      end
      
      def test_should_print_error_to_stderr
        $stderr.expects(:puts).with "--this-option-is-not-valid is not a valid option"
        Trapeze::Application.new '--this-option-is-not-valid'
      end
      
      def test_should_print_help_to_stdout
        $stdout.expects(:puts).with <<-end_stdout

Usage:

  trap [options]

Options:

  --input-files-pattern, -i filespattern   Sets a pattern for finding source
                                           code files to load and analyze. The
                                           syntax of filespattern conforms to
                                           Ruby's Dir.glob method. The default
                                           value of this option is
                                           'lib/**/*.rb'.

           --output-dir, -o path           Sets a path to a directory where
                                           generated files will be created. The
                                           default value of this option is
                                           'test/trapeze'.

                 --help, -h                Displays this help message.
        end_stdout
        Trapeze::Application.new '--this-option-is-not-valid'
      end
      
      def test_should_call_kernel_exit
        Kernel.expects :exit
        Trapeze::Application.new '--this-option-is-not-valid'
      end
      
    end
    
    class WithInvalidArg < Test::Unit::TestCase
      
      def setup
        $stderr.stubs :puts
        $stdout.stubs :puts
        Kernel.stubs :exit
      end
      
      def test_should_print_error_to_stderr
        $stderr.expects(:puts).with "this-arg-is-not-valid is not a valid argument"
        Trapeze::Application.new 'this-arg-is-not-valid'
      end
      
      def test_should_print_help_to_stdout
        $stdout.expects(:puts).with <<-end_stdout

Usage:

  trap [options]

Options:

  --input-files-pattern, -i filespattern   Sets a pattern for finding source
                                           code files to load and analyze. The
                                           syntax of filespattern conforms to
                                           Ruby's Dir.glob method. The default
                                           value of this option is
                                           'lib/**/*.rb'.

           --output-dir, -o path           Sets a path to a directory where
                                           generated files will be created. The
                                           default value of this option is
                                           'test/trapeze'.

                 --help, -h                Displays this help message.
        end_stdout
        Trapeze::Application.new 'this-arg-is-not-valid'
      end
      
      def test_should_call_kernel_exit
        Kernel.expects :exit
        Trapeze::Application.new 'this-arg-is-not-valid'
      end
      
    end
    
    class WithHelpOption < Test::Unit::TestCase
      
      def setup
        $stdout.stubs :puts
        Kernel.stubs :exit
      end
      
      def test_should_not_print_to_stderr
        $stderr.expects(:puts).never
        Trapeze::Application.new '--help'
      end
      
      def test_should_print_help_to_stdout
        $stdout.expects(:puts).with <<-end_stdout

Usage:

  trap [options]

Options:

  --input-files-pattern, -i filespattern   Sets a pattern for finding source
                                           code files to load and analyze. The
                                           syntax of filespattern conforms to
                                           Ruby's Dir.glob method. The default
                                           value of this option is
                                           'lib/**/*.rb'.

           --output-dir, -o path           Sets a path to a directory where
                                           generated files will be created. The
                                           default value of this option is
                                           'test/trapeze'.

                 --help, -h                Displays this help message.
        end_stdout
        Trapeze::Application.new '--help'
      end
      
      def test_should_call_kernel_exit
        Kernel.expects :exit
        Trapeze::Application.new '--help'
      end
      
    end
    
    class WithHOption < Test::Unit::TestCase
      
      def setup
        $stdout.stubs :puts
        Kernel.stubs :exit
      end
      
      def test_should_not_print_to_stderr
        $stderr.expects(:puts).never
        Trapeze::Application.new '-h'
      end
      
      def test_should_print_help_to_stdout
        $stdout.expects(:puts).with <<-end_stdout

Usage:

  trap [options]

Options:

  --input-files-pattern, -i filespattern   Sets a pattern for finding source
                                           code files to load and analyze. The
                                           syntax of filespattern conforms to
                                           Ruby's Dir.glob method. The default
                                           value of this option is
                                           'lib/**/*.rb'.

           --output-dir, -o path           Sets a path to a directory where
                                           generated files will be created. The
                                           default value of this option is
                                           'test/trapeze'.

                 --help, -h                Displays this help message.
        end_stdout
        Trapeze::Application.new '-h'
      end
      
      def test_should_call_kernel_exit
        Kernel.expects :exit
        Trapeze::Application.new '-h'
      end
      
    end
    
    class WithInputFilesPatternOption < Test::Unit::TestCase
      
      def test_should_not_print_to_stderr
        $stderr.expects(:puts).never
        Trapeze::Application.new *%w(--input-files-pattern foo)
      end
      
      def test_should_not_print_to_stdout
        $stdout.expects(:puts).never
        Trapeze::Application.new *%w(--input-files-pattern foo)
      end
      
      def test_should_not_call_kernel_exit
        Kernel.expects(:exit).never
        Trapeze::Application.new *%w(--input-files-pattern foo)
      end
      
    end
    
    class WithIOption < Test::Unit::TestCase
      
      def test_should_not_print_to_stderr
        $stderr.expects(:puts).never
        Trapeze::Application.new *%w(-i foo)
      end
      
      def test_should_not_print_to_stdout
        $stdout.expects(:puts).never
        Trapeze::Application.new *%w(-i foo)
      end
      
      def test_should_not_call_kernel_exit
        Kernel.expects(:exit).never
        Trapeze::Application.new *%w(-i foo)
      end
      
    end
    
    class WithOutputDirOption < Test::Unit::TestCase
      
      def test_should_not_print_to_stderr
        $stderr.expects(:puts).never
        Trapeze::Application.new *%w(--output-dir foo)
      end
      
      def test_should_not_print_to_stdout
        $stdout.expects(:puts).never
        Trapeze::Application.new *%w(--output-dir foo)
      end
      
      def test_should_not_call_kernel_exit
        Kernel.expects(:exit).never
        Trapeze::Application.new *%w(--output-dir foo)
      end
      
    end
    
    class WithOOption < Test::Unit::TestCase
      
      def test_should_not_print_to_stderr
        $stderr.expects(:puts).never
        Trapeze::Application.new *%w(-o foo)
      end
      
      def test_should_not_print_to_stdout
        $stdout.expects(:puts).never
        Trapeze::Application.new *%w(-o foo)
      end
      
      def test_should_not_call_kernel_exit
        Kernel.expects(:exit).never
        Trapeze::Application.new *%w(-o foo)
      end
      
    end
    
  end
  
  class WithNoArgs < Test::Unit::TestCase
    
    def setup
      Dir.stubs(:glob).returns stub_everything
      Trapeze::Loader.stubs(:new).returns stub_everything
      Trapeze::Probe.stubs(:new).returns stub_everything
      @mock_generator = stub_everything
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns @mock_generator
      @application = Trapeze::Application.new
    end
    
    def test_should_return_empty_array_when_sent_args
      assert_equal [], @application.args
    end
    
    def test_should_return_default_pattern_when_sent_input_files_pattern
      assert_equal 'lib/**/*.rb', @application.input_files_pattern
    end
    
    def test_should_return_default_path_when_sent_output_dir
      assert_equal 'test/trapeze', @application.output_dir
    end
    
    def test_should_call_dir_glob_with_default_pattern_when_sent_runEXCLAMATION
      Dir.expects(:glob).with('lib/**/*.rb').returns stub_everything
      @application.run!
    end
    
    def test_should_call_loader_new_with_expected_filenames_when_sent_runEXCLAMATION
      Dir.stubs(:glob).returns :stubbed_filenames
      Trapeze::Loader.expects(:new).with :stubbed_filenames
      @application.run!
    end
    
    def test_should_call_probe_new_with_loader_when_sent_runEXCLAMATION
      Trapeze::Loader.stubs(:new).returns :stubbed_loader
      Trapeze::Probe.expects(:new).with(:stubbed_loader).returns stub_everything
      @application.run!
    end
    
    def test_should_call_test_unit_new_with_default_input_files_pattern_attribute_and_default_output_dir_attribute_and_probe_attribute_when_sent_runEXCLAMATION
      Trapeze::Probe.stubs(:new).returns :stubbed_probe
      Trapeze::SuiteGenerators::TestUnit.expects(:new).with(:input_files_pattern => 'lib/**/*.rb',
                                                            :output_dir => 'test/trapeze',
                                                            :probe => :stubbed_probe).returns stub_everything
      @application.run!
    end
    
    def test_should_call_generateEXCLAMATION_with_no_args_on_generator_when_sent_runEXCLAMATION
      @mock_generator.expects(:generate!).with()
      @application.run!
    end
    
    def test_should_return_result_of_call_to_generateEXCLAMATION_on_generator_when_sent_runEXCLAMATION
      @mock_generator.stubs(:generate!).returns :generate_result
      assert_equal :generate_result, @application.run!
    end
    
  end
  
  class WithInputFilesPatternOption < Test::Unit::TestCase
    
    def setup
      Dir.stubs(:glob).returns stub_everything
      Trapeze::Loader.stubs(:new).returns stub_everything
      Trapeze::Probe.stubs(:new).returns stub_everything
      @mock_generator = stub_everything
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns @mock_generator
      @application = Trapeze::Application.new(*%w(--input-files-pattern foo))
    end
    
    def test_should_return_array_containing_expected_args_when_sent_args
      assert_equal %w(--input-files-pattern foo), @application.args
    end
    
    def test_should_return_expected_pattern_when_sent_input_files_pattern
      assert_equal 'foo', @application.input_files_pattern
    end
    
    def test_should_return_default_path_when_sent_output_dir
      assert_equal 'test/trapeze', @application.output_dir
    end
    
    def test_should_call_dir_glob_with_expected_pattern_when_sent_runEXCLAMATION
      Dir.expects(:glob).with('foo').returns stub_everything
      @application.run!
    end
    
    def test_should_call_loader_new_with_expected_filenames_when_sent_runEXCLAMATION
      Dir.stubs(:glob).returns :stubbed_filenames
      Trapeze::Loader.expects(:new).with :stubbed_filenames
      @application.run!
    end
    
    def test_should_call_probe_new_with_loader_when_sent_runEXCLAMATION
      Trapeze::Loader.stubs(:new).returns :stubbed_loader
      Trapeze::Probe.expects(:new).with(:stubbed_loader).returns stub_everything
      @application.run!
    end
    
    def test_should_call_test_unit_new_with_expected_input_files_pattern_attribute_and_default_output_dir_attribute_and_probe_attribute_when_sent_runEXCLAMATION
      Trapeze::Probe.stubs(:new).returns :stubbed_probe
      Trapeze::SuiteGenerators::TestUnit.expects(:new).with(:input_files_pattern => 'foo',
                                                            :output_dir => 'test/trapeze',
                                                            :probe => :stubbed_probe).returns stub_everything
      @application.run!
    end
    
    def test_should_call_generateEXCLAMATION_with_no_args_on_generator_when_sent_runEXCLAMATION
      @mock_generator.expects(:generate!).with()
      @application.run!
    end
    
    def test_should_return_result_of_call_to_generateEXCLAMATION_on_generator_when_sent_runEXCLAMATION
      @mock_generator.stubs(:generate!).returns :generate_result
      assert_equal :generate_result, @application.run!
    end
    
  end
  
  class WithIOption < Test::Unit::TestCase
    
    def setup
      Dir.stubs(:glob).returns stub_everything
      Trapeze::Loader.stubs(:new).returns stub_everything
      Trapeze::Probe.stubs(:new).returns stub_everything
      @mock_generator = stub_everything
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns @mock_generator
      @application = Trapeze::Application.new(*%w(-i foo))
    end
    
    def test_should_return_array_containing_expected_args_when_sent_args
      assert_equal %w(-i foo), @application.args
    end
    
    def test_should_return_expected_pattern_when_sent_input_files_pattern
      assert_equal 'foo', @application.input_files_pattern
    end
    
    def test_should_return_default_path_when_sent_output_dir
      assert_equal 'test/trapeze', @application.output_dir
    end
    
    def test_should_call_dir_glob_with_expected_pattern_when_sent_runEXCLAMATION
      Dir.expects(:glob).with('foo').returns stub_everything
      @application.run!
    end
    
    def test_should_call_loader_new_with_expected_filenames_when_sent_runEXCLAMATION
      Dir.stubs(:glob).returns :stubbed_filenames
      Trapeze::Loader.expects(:new).with :stubbed_filenames
      @application.run!
    end
    
    def test_should_call_probe_new_with_loader_when_sent_runEXCLAMATION
      Trapeze::Loader.stubs(:new).returns :stubbed_loader
      Trapeze::Probe.expects(:new).with(:stubbed_loader).returns stub_everything
      @application.run!
    end
    
    def test_should_call_test_unit_new_with_expected_input_files_pattern_attribute_and_default_output_dir_attribute_and_probe_attribute_when_sent_runEXCLAMATION
      Trapeze::Probe.stubs(:new).returns :stubbed_probe
      Trapeze::SuiteGenerators::TestUnit.expects(:new).with(:input_files_pattern => 'foo',
                                                            :output_dir => 'test/trapeze',
                                                            :probe => :stubbed_probe).returns stub_everything
      @application.run!
    end
    
    def test_should_call_generateEXCLAMATION_with_no_args_on_generator_when_sent_runEXCLAMATION
      @mock_generator.expects(:generate!).with()
      @application.run!
    end
    
    def test_should_return_result_of_call_to_generateEXCLAMATION_on_generator_when_sent_runEXCLAMATION
      @mock_generator.stubs(:generate!).returns :generate_result
      assert_equal :generate_result, @application.run!
    end
    
  end
  
  class WithOutputDirOption < Test::Unit::TestCase
    
    def setup
      Dir.stubs(:glob).returns stub_everything
      Trapeze::Loader.stubs(:new).returns stub_everything
      Trapeze::Probe.stubs(:new).returns stub_everything
      @mock_generator = stub_everything
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns @mock_generator
      @application = Trapeze::Application.new(*%w(--output-dir foo))
    end
    
    def test_should_return_array_containing_expected_args_when_sent_args
      assert_equal %w(--output-dir foo), @application.args
    end
    
    def test_should_return_default_pattern_when_sent_input_files_pattern
      assert_equal 'lib/**/*.rb', @application.input_files_pattern
    end
    
    def test_should_return_expected_path_when_sent_output_dir
      assert_equal 'foo', @application.output_dir
    end
    
    def test_should_call_dir_glob_with_default_pattern_when_sent_runEXCLAMATION
      Dir.expects(:glob).with('lib/**/*.rb').returns stub_everything
      @application.run!
    end
    
    def test_should_call_loader_new_with_expected_filenames_when_sent_runEXCLAMATION
      Dir.stubs(:glob).returns :stubbed_filenames
      Trapeze::Loader.expects(:new).with :stubbed_filenames
      @application.run!
    end
    
    def test_should_call_probe_new_with_loader_when_sent_runEXCLAMATION
      Trapeze::Loader.stubs(:new).returns :stubbed_loader
      Trapeze::Probe.expects(:new).with(:stubbed_loader).returns stub_everything
      @application.run!
    end
    
    def test_should_call_test_unit_new_with_expected_input_files_pattern_attribute_and_default_output_dir_attribute_and_probe_attribute_when_sent_runEXCLAMATION
      Trapeze::Probe.stubs(:new).returns :stubbed_probe
      Trapeze::SuiteGenerators::TestUnit.expects(:new).with(:input_files_pattern => 'lib/**/*.rb',
                                                            :output_dir => 'foo',
                                                            :probe => :stubbed_probe).returns stub_everything
      @application.run!
    end
    
    def test_should_call_generateEXCLAMATION_with_no_args_on_generator_when_sent_runEXCLAMATION
      @mock_generator.expects(:generate!).with()
      @application.run!
    end
    
    def test_should_return_result_of_call_to_generateEXCLAMATION_on_generator_when_sent_runEXCLAMATION
      @mock_generator.stubs(:generate!).returns :generate_result
      assert_equal :generate_result, @application.run!
    end
    
  end
  
  class WithOOption < Test::Unit::TestCase
    
    def setup
      Dir.stubs(:glob).returns stub_everything
      Trapeze::Loader.stubs(:new).returns stub_everything
      Trapeze::Probe.stubs(:new).returns stub_everything
      @mock_generator = stub_everything
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns @mock_generator
      @application = Trapeze::Application.new(*%w(-o foo))
    end
    
    def test_should_return_array_containing_expected_args_when_sent_args
      assert_equal %w(-o foo), @application.args
    end
    
    def test_should_return_default_pattern_when_sent_input_files_pattern
      assert_equal 'lib/**/*.rb', @application.input_files_pattern
    end
    
    def test_should_return_expected_path_when_sent_output_dir
      assert_equal 'foo', @application.output_dir
    end
    
    def test_should_call_dir_glob_with_default_pattern_when_sent_runEXCLAMATION
      Dir.expects(:glob).with('lib/**/*.rb').returns stub_everything
      @application.run!
    end
    
    def test_should_call_loader_new_with_expected_filenames_when_sent_runEXCLAMATION
      Dir.stubs(:glob).returns :stubbed_filenames
      Trapeze::Loader.expects(:new).with :stubbed_filenames
      @application.run!
    end
    
    def test_should_call_probe_new_with_loader_when_sent_runEXCLAMATION
      Trapeze::Loader.stubs(:new).returns :stubbed_loader
      Trapeze::Probe.expects(:new).with(:stubbed_loader).returns stub_everything
      @application.run!
    end
    
    def test_should_call_test_unit_new_with_expected_input_files_pattern_attribute_and_default_output_dir_attribute_and_probe_attribute_when_sent_runEXCLAMATION
      Trapeze::Probe.stubs(:new).returns :stubbed_probe
      Trapeze::SuiteGenerators::TestUnit.expects(:new).with(:input_files_pattern => 'lib/**/*.rb',
                                                            :output_dir => 'foo',
                                                            :probe => :stubbed_probe).returns stub_everything
      @application.run!
    end
    
    def test_should_call_generateEXCLAMATION_with_no_args_on_generator_when_sent_runEXCLAMATION
      @mock_generator.expects(:generate!).with()
      @application.run!
    end
    
    def test_should_return_result_of_call_to_generateEXCLAMATION_on_generator_when_sent_runEXCLAMATION
      @mock_generator.stubs(:generate!).returns :generate_result
      assert_equal :generate_result, @application.run!
    end
    
  end
  
end

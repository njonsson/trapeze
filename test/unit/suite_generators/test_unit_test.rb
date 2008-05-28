require File.expand_path("#{File.dirname __FILE__}/../../test")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/trapeze/suite_generators/test_unit")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/../../assertion_helpers_extension")
require 'rubygems'
require 'mocha'
require 'stringio'

module Trapeze::SuiteGenerators::TestUnitTest
  
  module New
    
    class WithNoAttributes < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':input_files_pattern attribute required') do
          Trapeze::SuiteGenerators::TestUnit.new
        end
      end
      
    end
    
    class WithInputFilesPatternAttribute < Test::Unit::TestCase
      
      def test_should_raise_argument_error
        assert_raise_message(ArgumentError,
                             ':output_dir attribute required') do
          Trapeze::SuiteGenerators::TestUnit.new :input_files_pattern => 'foo'
        end
      end
      
    end
    
    class WithInputFilesPatternAttributeAndOutputDirAttributeAsFile <
          Test::Unit::TestCase
      
      def test_should_call_file_fileQUESTION_with_output_dir_attribute
        File.expects(:file?).with('bar').returns true
        begin
          Trapeze::SuiteGenerators::TestUnit.new :input_files_pattern => 'foo',
                                                 :output_dir => 'bar'
        rescue ArgumentError
        end
      end
      
      def test_should_raise_argument_error
        File.stubs(:file?).returns true
        assert_raise_message(ArgumentError,
                             ':output_dir attribute must not be a file') do
          Trapeze::SuiteGenerators::TestUnit.new :input_files_pattern => 'foo',
                                                 :output_dir => 'foo'
        end
      end
      
    end
    
    class WithInputFilesPatternAttributeAndOutputDirAttributeNotAsFile <
          Test::Unit::TestCase
      
      def test_should_call_file_fileQUESTION_with_output_dir_attribute
        File.expects(:file?).with('bar').returns false
        begin
          Trapeze::SuiteGenerators::TestUnit.new :input_files_pattern => 'foo',
                                                 :output_dir => 'bar'
        rescue ArgumentError
        end
      end
      
      def test_should_raise_argument_error
        File.stubs(:file?).returns false
        assert_raise_message(ArgumentError, ':probe attribute required') do
          Trapeze::SuiteGenerators::TestUnit.new :input_files_pattern => 'foo',
                                                 :output_dir => 'bar'
        end
      end
      
    end
    
    class WithInputFilesPatternAttributeAndOutputDirAttributeNotAsFileAndProbeAttributeHavingNoResults <
          Test::Unit::TestCase
      
      def setup
        File.stubs(:file?).returns false
        @mock_probe = mock
        @mock_probe.stubs(:class_probe_results).returns []
        @mock_probe.stubs(:module_probe_results).returns []
        @mock_probe.stubs(:top_level_method_probe_results).returns []
        @generator = Trapeze::SuiteGenerators::TestUnit.new(:input_files_pattern => 'foo',
                                                            :output_dir => 'bar',
                                                            :probe => @mock_probe)
        File.stubs(:exist?).returns false
        FileUtils.stubs :rm_rf
        FileUtils.stubs :mkdir_p
        File.stubs(:open).yields stub_everything
      end
      
      def test_should_call_file_fileQUESTION_with_output_dir_attribute
        File.expects(:file?).with('bar').returns false
        assert_nothing_raised do
          Trapeze::SuiteGenerators::TestUnit.new :input_files_pattern => 'foo',
                                                 :output_dir => 'bar',
                                                 :probe => 'baz'
        end
      end
      
      def test_should_return_expected_input_files_pattern_when_sent_input_files_pattern
        assert_equal 'foo', @generator.input_files_pattern
      end
      
      def test_should_return_expected_output_dir_when_sent_output_dir
        assert_equal 'bar', @generator.output_dir
      end
      
      def test_should_return_expected_probe_when_sent_probe
        assert_equal @mock_probe, @generator.probe
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        assert_equal @generator, @generator.generate!
      end
      
      def test_should_call_probe_class_probe_results_when_sent_generateEXCLAMATION
        @mock_probe.expects(:class_probe_results).with().returns []
        @generator.generate!
      end
      
      def test_should_call_probe_module_probe_results_when_sent_generateEXCLAMATION
        @mock_probe.expects(:module_probe_results).with().returns []
        @generator.generate!
      end
      
      def test_should_call_probe_top_level_method_probe_results_when_sent_generateEXCLAMATION
        @mock_probe.expects(:top_level_method_probe_results).with().returns []
        @generator.generate!
      end
      
      def test_should_call_file_existQUESTION_with_output_dir_when_sent_generateEXCLAMATION
        File.expects(:exist?).with('bar').returns false
        @generator.generate!
      end
      
      def test_should_call_file_utils_rm_rf_with_output_dir_when_sent_generateEXCLAMATION_with_output_dir_as_directory
        File.stubs(:exist?).returns true
        FileUtils.expects(:rm_rf).with 'bar'
        @generator.generate!
      end
      
      def test_should_call_file_utils_mkdir_p_with_output_dir_when_sent_generateEXCLAMATION_with_output_dir_not_as_directory
        FileUtils.expects(:mkdir_p).with 'bar'
        @generator.generate!
      end
      
      def test_should_call_file_open_with_suite_filename_and_expected_modestring_when_sent_generateEXCLAMATION
        File.expects(:open).with('bar/SUITE.rb', 'w').yields stub_everything
        @generator.generate!
      end
      
      def test_should_print_expected_content_to_suite_file_when_sent_generateEXCLAMATION
        mock_io = mock('IO')
        mock_io.expects(:print).with <<-end_print
# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

Dir.glob(File.expand_path("\#{File.dirname __FILE__}/../foo")) do |source_file|
  require File.expand_path(source_file)
end

Dir.glob(File.expand_path("\#{File.dirname __FILE__}/**/*_test.rb")) do |test_file|
  require File.expand_path(test_file)
end
        end_print
        File.stubs(:open).yields mock_io
        @generator.generate!
      end
      
    end
    
  end
  
end

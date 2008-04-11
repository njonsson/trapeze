require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/application")
require 'test/unit'
require 'rubygems'
require 'mocha'
require File.expand_path("#{File.dirname __FILE__}/../assertion_helpers_extension")

module Trapeze::ApplicationTest
  
  class RunWithNoArgs < Test::Unit::TestCase
    
    def setup
      Dir.stubs(:glob).returns stub_everything
      Trapeze::Loader.stubs(:new).returns stub_everything
      Trapeze::Probe.stubs(:new).returns stub_everything
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns stub_everything
    end
    
    def test_should_call_dir_glob_with_default_pattern_when_sent_run
      Dir.expects(:glob).with('lib/**/*.rb').returns stub_everything
      Trapeze::Application.run
    end
    
    def test_should_call_loader_new_with_expected_filenames_when_sent_run
      Dir.stubs(:glob).returns :stubbed_filenames
      Trapeze::Loader.expects(:new).with :stubbed_filenames
      Trapeze::Application.run
    end
    
    def test_should_call_probe_new_with_loader_when_sent_run
      Trapeze::Loader.stubs(:new).returns :stubbed_loader
      Trapeze::Probe.expects(:new).with(:stubbed_loader).returns stub_everything
      Trapeze::Application.run
    end
    
    def test_should_call_test_unit_new_with_path_attribute_of_default_path_and_probe_attribute_of_probe_when_sent_run
      Trapeze::Probe.expects(:new).returns :stubbed_probe
      Trapeze::SuiteGenerators::TestUnit.expects(:new).with(:path => 'test/trapeze',
                                                            :probe => :stubbed_probe).returns stub_everything
      Trapeze::Application.run
    end
    
    def test_should_call_generator_generateEXCLAMATION_with_no_args_when_sent_run
      mock_generator = mock
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns mock_generator
      mock_generator.expects(:generate!).with()
      Trapeze::Application.run
    end
    
    def test_should_return_result_of_generator_generateEXCLAMATION_when_sent_run
      stubbed_generator = stub_everything
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns stubbed_generator
      stubbed_generator.stubs(:generate!).returns :generate_result
      assert_equal :generate_result, Trapeze::Application.run
    end
    
  end
  
  class RunWithOneArg < Test::Unit::TestCase
    
    def test_should_raise_argument_error
      assert_raise_message(ArgumentError, 'expected two arguments') do
        Trapeze::Application.run 'foo'
      end
    end
    
  end
  
  class RunWithTwoArgs < Test::Unit::TestCase
    
    def setup
      Dir.stubs(:glob).returns stub_everything
      Trapeze::Loader.stubs(:new).returns stub_everything
      Trapeze::Probe.stubs(:new).returns stub_everything
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns stub_everything
    end
    
    def test_should_call_dir_glob_with_first_arg_when_sent_run
      Dir.expects(:glob).with(:arg1).returns stub_everything
      Trapeze::Application.run :arg1, :arg2
    end
    
    def test_should_call_loader_new_with_expected_filenames_when_sent_run
      Dir.stubs(:glob).returns :stubbed_filenames
      Trapeze::Loader.expects(:new).with :stubbed_filenames
      Trapeze::Application.run :arg1, :arg2
    end
    
    def test_should_call_probe_new_with_loader_when_sent_run
      Trapeze::Loader.stubs(:new).returns :stubbed_loader
      Trapeze::Probe.expects(:new).with(:stubbed_loader).returns stub_everything
      Trapeze::Application.run :arg1, :arg2
    end
    
    def test_should_call_test_unit_new_with_path_attribute_of_second_arg_and_probe_attribute_of_probe_when_sent_run
      Trapeze::Probe.expects(:new).returns :stubbed_probe
      Trapeze::SuiteGenerators::TestUnit.expects(:new).with(:path => :arg2,
                                                            :probe => :stubbed_probe).returns stub_everything
      Trapeze::Application.run :arg1, :arg2
    end
    
    def test_should_call_generator_generateEXCLAMATION_with_no_args_when_sent_run
      mock_generator = mock
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns mock_generator
      mock_generator.expects(:generate!).with()
      Trapeze::Application.run :arg1, :arg2
    end
    
    def test_should_return_result_of_generator_generateEXCLAMATION_when_sent_run
      stubbed_generator = stub_everything
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns stubbed_generator
      stubbed_generator.stubs(:generate!).returns :generate_result
      assert_equal :generate_result, Trapeze::Application.run(:arg1, :arg2)
    end
    
  end
  
  class RunWithThreeArgs < Test::Unit::TestCase
    
    def test_should_raise_argument_error
      assert_raise_message(ArgumentError, 'expected two arguments') do
        Trapeze::Application.run 'foo', 'bar', 'baz'
      end
    end
    
  end
  
end

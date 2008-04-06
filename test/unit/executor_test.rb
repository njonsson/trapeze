require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/executor")
require 'test/unit'
require 'rubygems'
require 'mocha'
require File.expand_path("#{File.dirname __FILE__}/../assertion_helpers_extension")

module Trapeze::ExecutorTest
  
  class WithNoArgs < Test::Unit::TestCase
    
    def setup
      @executor = Trapeze::Executor.new
      Dir.stubs(:glob).returns stub_everything
      Trapeze::Loader.stubs(:new).returns stub_everything
      Trapeze::Probes::BasicProbe.stubs(:new).returns stub_everything
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns stub_everything
    end
    
    def test_should_return_empty_array_when_sent_args
      assert_equal [], @executor.args
    end
    
    def test_should_call_dir_glob_with_default_pattern_when_sent_executeEXCLAMATION
      Dir.expects(:glob).with('lib/**/*.rb').returns stub_everything
      @executor.execute!
    end
    
    def test_should_call_loader_new_with_expected_filenames_when_sent_executeEXCLAMATION
      Dir.stubs(:glob).returns :stubbed_filenames
      Trapeze::Loader.expects(:new).with :stubbed_filenames
      @executor.execute!
    end
    
    def test_should_call_basic_probe_new_with_loader_when_sent_executeEXCLAMATION
      Trapeze::Loader.stubs(:new).returns :stubbed_loader
      Trapeze::Probes::BasicProbe.expects(:new).with(:stubbed_loader).returns stub_everything
      @executor.execute!
    end
    
    def test_should_call_test_unit_new_with_path_attribute_of_default_path_and_probe_attribute_of_basic_probe_when_sent_executeEXCLAMATION
      Trapeze::Probes::BasicProbe.expects(:new).returns :stubbed_probe
      Trapeze::SuiteGenerators::TestUnit.expects(:new).with(:path => 'test/trapeze',
                                                            :probe => :stubbed_probe).returns stub_everything
      @executor.execute!
    end
    
    def test_should_call_generator_generateEXCLAMATION_with_no_args_when_sent_executeEXCLAMATION
      mock_generator = mock
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns mock_generator
      mock_generator.expects(:generate!).with()
      @executor.execute!
    end
    
    def test_should_return_result_of_generator_generateEXCLAMATION_when_sent_executeEXCLAMATION
      stubbed_generator = stub_everything
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns stubbed_generator
      stubbed_generator.stubs(:generate!).returns :generate_result
      assert_equal :generate_result, @executor.execute!
    end
    
  end
  
  class WithOneArg < Test::Unit::TestCase
    
    def test_should_raise_argument_error
      assert_raise_message(ArgumentError, 'expected two arguments') do
        Trapeze::Executor.new 'foo'
      end
    end
    
  end
  
  class WithTwoArgs < Test::Unit::TestCase
    
    def setup
      @executor = Trapeze::Executor.new(:arg1, :arg2)
      Dir.stubs(:glob).returns stub_everything
      Trapeze::Loader.stubs(:new).returns stub_everything
      Trapeze::Probes::BasicProbe.stubs(:new).returns stub_everything
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns stub_everything
    end
    
    def test_should_return_array_containing_expected_args_when_sent_args
      assert_equal [:arg1, :arg2], @executor.args
    end
    
    def test_should_call_dir_glob_with_first_arg_when_sent_executeEXCLAMATION
      Dir.expects(:glob).with(:arg1).returns stub_everything
      @executor.execute!
    end
    
    def test_should_call_loader_new_with_expected_filenames_when_sent_executeEXCLAMATION
      Dir.stubs(:glob).returns :stubbed_filenames
      Trapeze::Loader.expects(:new).with :stubbed_filenames
      @executor.execute!
    end
    
    def test_should_call_basic_probe_new_with_loader_when_sent_executeEXCLAMATION
      Trapeze::Loader.stubs(:new).returns :stubbed_loader
      Trapeze::Probes::BasicProbe.expects(:new).with(:stubbed_loader).returns stub_everything
      @executor.execute!
    end
    
    def test_should_call_test_unit_new_with_path_attribute_of_second_arg_and_probe_attribute_of_basic_probe_when_sent_executeEXCLAMATION
      Trapeze::Probes::BasicProbe.expects(:new).returns :stubbed_probe
      Trapeze::SuiteGenerators::TestUnit.expects(:new).with(:path => :arg2,
                                                            :probe => :stubbed_probe).returns stub_everything
      @executor.execute!
    end
    
    def test_should_call_generator_generateEXCLAMATION_with_no_args_when_sent_executeEXCLAMATION
      mock_generator = mock
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns mock_generator
      mock_generator.expects(:generate!).with()
      @executor.execute!
    end
    
    def test_should_return_result_of_generator_generateEXCLAMATION_when_sent_executeEXCLAMATION
      stubbed_generator = stub_everything
      Trapeze::SuiteGenerators::TestUnit.stubs(:new).returns stubbed_generator
      stubbed_generator.stubs(:generate!).returns :generate_result
      assert_equal :generate_result, @executor.execute!
    end
    
  end
  
  class WithThreeArgs < Test::Unit::TestCase
    
    def test_should_raise_argument_error
      assert_raise_message(ArgumentError, 'expected two arguments') do
        Trapeze::Executor.new 'foo', 'bar', 'baz'
      end
    end
    
  end
  
end

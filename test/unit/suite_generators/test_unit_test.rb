require File.expand_path("#{File.dirname __FILE__}/../../test")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/suite_generators/test_unit")
require 'test/unit'
require 'rubygems'
require 'mocha'

module Trapeze::SuiteGenerators::TestUnitTest
  
  class WithNonexistentDirectory < Test::Unit::TestCase
    
    def test_should_call_file_directoryQUESTION_with_expected_path
      File.expects(:directory?).with('foo').returns false
      begin
        Trapeze::SuiteGenerators::TestUnit.new 'foo'
      rescue ArgumentError
      end
    end
    
    def test_should_raise_argument_error
      File.stubs(:directory?).returns false
      assert_raise(ArgumentError) do
        Trapeze::SuiteGenerators::TestUnit.new 'foo'
      end
    end
    
  end
  
  class WithExistingDirectory < Test::Unit::TestCase
    
    def test_should_call_file_directoryQUESTION_with_expected_path
      File.expects(:directory?).with('foo').returns true
      Trapeze::SuiteGenerators::TestUnit.new 'foo'
    end
    
    def test_should_return_expected_path_when_sent_path
      File.stubs(:directory?).returns true
      generator = Trapeze::SuiteGenerators::TestUnit.new('foo')
      assert_equal 'foo', generator.path
    end
    
    def test_should_return_self_when_sent_generateEXCLAMATION
      File.stubs(:directory?).returns true
      generator = Trapeze::SuiteGenerators::TestUnit.new('foo')
      Dir.stubs :empty_dir!
      assert_equal generator, generator.generate!({})
    end
    
    def test_should_call_dir_empty_dirEXCLAMATION_with_path_when_sent_generateEXCLAMATION
      File.stubs(:directory?).returns true
      generator = Trapeze::SuiteGenerators::TestUnit.new('foo')
      Dir.expects(:empty_dir!).with 'foo'
      generator.generate!({})
    end
    
  end
  
end

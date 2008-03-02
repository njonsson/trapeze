require File.expand_path("#{File.dirname __FILE__}/../../test")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/suite_generators/test_unit")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/to_method_extension")
require 'test/unit'
require 'rubygems'
require 'mocha'

module Trapeze::SuiteGenerators::TestUnitTest
  
  module New
    
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
      
    end
    
  end
  
  module GenerateEXCLAMATION
    
    class WithNoCases < Test::Unit::TestCase
      
      def setup
        File.stubs(:directory?).returns true
        @generator = Trapeze::SuiteGenerators::TestUnit.new('foo')
      end
      
      def test_should_return_self
        Dir.stubs :empty_dir!
        assert_equal @generator, @generator.generate!([])
      end
      
      def test_should_call_dir_empty_dirEXCLAMATION_with_path
        Dir.expects(:empty_dir!).with 'foo'
        @generator.generate!([])
      end
      
    end
    
    class WithOneCaseProbingMethod < Test::Unit::TestCase
      
      module FooModule
        
        def bar; end
        
      end
      
      def setup
        File.stubs(:directory?).returns true
        @generator = Trapeze::SuiteGenerators::TestUnit.new('foo')
        @cases = [{:method => 'bar'.to_instance_method(FooModule),
                   :args => [],
                   :returned => nil}]
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        Dir.stubs :empty_dir!
        File.stubs(:open).yields stub_everything
        assert_equal @generator, @generator.generate!(@cases)
      end
      
      def test_should_call_dir_empty_dirEXCLAMATION_with_path
        Dir.expects(:empty_dir!).with 'foo'
        File.stubs(:open).yields stub_everything
        @generator.generate! @cases
      end
      
      def test_should_create_or_append_to_expected_file_with_expected_content
        Dir.stubs(:empty_dir!).with 'foo'
        mock_file = mock
        mock_file.expects(:puts).with "require 'test/unit'"
        mock_file.expects(:puts).with "require 'rubygems'"
        mock_file.expects(:puts).with "require 'mocha'"
        mock_file.expects(:puts).with ''
        mock_file.expects(:puts).with 'class BarTest < Test::Unit::TestCase'
        mock_file.expects(:puts).with '  '
        mock_file.expects(:puts).with '  def test_truth'
        mock_file.expects(:puts).with '    assert true'
        mock_file.expects(:puts).with '  end'
        mock_file.expects(:puts).with '  '
        mock_file.expects(:puts).with 'end'
        File.expects(:open).with('foo/bar_test.rb', 'a').yields mock_file
        @generator.generate! @cases
      end
      
    end
    
  end
  
end

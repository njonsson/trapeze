require File.expand_path("#{File.dirname __FILE__}/../../test")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/suite_generators/test_unit")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/to_method_extension")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/../../assertion_helpers_extension")
require 'rubygems'
require 'mocha'

module Trapeze::SuiteGenerators::TestUnitTest
  
  module New
    
    class WithNonexistentDirectory < Test::Unit::TestCase
      
      def setup
        File.stubs(:directory?).returns false
        File.stubs(:exist?).returns false
      end
      
      def test_should_call_file_directoryQUESTION_with_expected_path
        File.expects(:directory?).with 'foo'
        Trapeze::SuiteGenerators::TestUnit.new 'foo'
      end
      
      def test_should_call_file_existQUESTION_with_expected_path
        File.expects(:exist?).with 'foo'
        Trapeze::SuiteGenerators::TestUnit.new 'foo'
      end
      
    end
    
    class WithFileInsteadOfDirectory < Test::Unit::TestCase
      
      def setup
        File.stubs(:directory?).returns false
        File.stubs(:exist?).returns true
      end
      
      def test_should_call_file_directoryQUESTION_with_expected_path
        File.expects(:directory?).with('foo').returns false
        begin
          Trapeze::SuiteGenerators::TestUnit.new 'foo'
        rescue ArgumentError
        end
      end
      
      def test_should_call_file_existQUESTION_with_expected_path
        File.expects(:exist?).with('foo').returns true
        begin
          Trapeze::SuiteGenerators::TestUnit.new 'foo'
        rescue ArgumentError
        end
      end
      
      def test_should_raise_argument_error
        File.stubs(:exist?).returns true
        assert_raise_message(ArgumentError, 'path must be a directory') do
          Trapeze::SuiteGenerators::TestUnit.new 'foo'
        end
      end
      
    end
    
    class WithExistingDirectory < Test::Unit::TestCase
      
      def setup
        File.stubs(:directory?).returns true
        File.stubs(:exist?).returns false
      end
      
      def test_should_call_file_directoryQUESTION_with_expected_path
        File.expects(:directory?).with('foo').returns true
        Trapeze::SuiteGenerators::TestUnit.new 'foo'
      end
      
      def test_should_return_expected_path_when_sent_path
        generator = Trapeze::SuiteGenerators::TestUnit.new('foo')
        assert_equal 'foo', generator.path
      end
      
    end
    
  end
  
  module GenerateEXCLAMATION
    
    class WithNoCases < Test::Unit::TestCase
      
      def setup
        File.stubs(:directory?).returns true
        Dir.stubs :truncate
        File.stubs :open
        @generator = Trapeze::SuiteGenerators::TestUnit.new('foo')
      end
      
      def test_should_return_self
        assert_equal @generator, @generator.generate!([])
      end
      
      def test_should_call_dir_truncate_with_path
        Dir.expects(:truncate).with 'foo'
        @generator.generate! []
      end
      
      def test_should_call_file_open_with_path_to_filename_and_expected_modestring
        File.expects(:open).with 'foo/SUITE.rb', 'w'
        @generator.generate! []
      end
      
    end
    
    class WithOneCaseProbingMethod < Test::Unit::TestCase
      
      module FooModule
        
        def bar; end
        
      end
      
      def setup
        File.stubs(:directory?).returns true
        Dir.stubs :truncate
        File.stubs :open
        @generator = Trapeze::SuiteGenerators::TestUnit.new('foo')
        @cases = [{:method => 'bar'.to_instance_method(FooModule),
                   :args => [],
                   :returned => nil}]
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        assert_equal @generator, @generator.generate!(@cases)
      end
      
      def test_should_call_dir_truncate_with_path
        Dir.expects(:truncate).with 'foo'
        @generator.generate! @cases
      end
      
      def test_should_call_file_open_with_path_to_filename_and_expected_modestring
        File.expects(:open).with 'foo/SUITE.rb', 'w'
        @generator.generate! []
      end
      
      def test_should_create_or_append_to_expected_file_with_expected_content
        expected_source = <<-end_expected_source
# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class Test_ < Test::Unit::TestCase
  
  def test_foo_returns_nil
    assert_nil foo
  end
  
end
        end_expected_source
        actual_source_io = StringIO.new
        File.stubs(:open).with('foo/_test.rb', 'a+').yields actual_source_io
        @generator.generate! @cases
        assert_equal expected_source, actual_source_io.string
      end
      
    end
    
  end
  
end

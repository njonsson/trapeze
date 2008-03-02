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
        Dir.stubs :truncate
        assert_equal @generator, @generator.generate!([])
      end
      
      def test_should_call_dir_truncate_with_path
        Dir.expects(:truncate).with 'foo'
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
        Dir.stubs :truncate
        File.stubs(:open).yields stub_everything
        assert_equal @generator, @generator.generate!(@cases)
      end
      
      def test_should_call_dir_truncate_with_path
        Dir.expects(:truncate).with 'foo'
        File.stubs(:open).yields stub_everything
        @generator.generate! @cases
      end
      
      def test_should_create_or_append_to_expected_file_with_expected_content
        Dir.stubs(:truncate).with 'foo'
        expected_source = <<-end_expected_source
require 'test/unit'
require 'rubygems'
require 'mocha'

class BarTest < Test::Unit::TestCase
  
  def test_bar
    assert_nil Object.bar
  end
  
end
        end_expected_source
        actual_source_io = StringIO.new
        File.expects(:open).with('foo/bar_test.rb', 'a').yields actual_source_io
        @generator.generate! @cases
        assert_equal expected_source, actual_source_io.string
      end
      
    end
    
  end
  
end

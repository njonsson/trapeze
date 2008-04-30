require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/sandbox")
require 'test/unit'
require 'rubygems'
require 'mocha'

module Trapeze::SandboxTest
  
  class Create < Test::Unit::TestCase
    
    def setup
      Trapeze.stubs(:const_defined?).returns false
      Trapeze.stubs(:const_set).returns :stubbed_module
    end
    
    def test_should_call_rand_on_kernel_with_10000
      Kernel.expects(:rand).with 10000
      Trapeze::Sandbox.create
    end
    
    def test_should_call_const_definedQUESTION_on_trapeze_with_name_matching_expected_pattern
      Trapeze.expects(:const_defined?).with do |name|
        name =~ /^Sandbox\d{1,4}$/
      end
      Trapeze::Sandbox.create
    end
    
    def test_should_call_rand_on_kernel_with_10000_twice_if_const_defined
      Kernel.expects(:rand).with(10000).times 2
      Trapeze.stubs(:const_defined?).returns true, false
      Trapeze::Sandbox.create
    end
    
    def test_should_call_const_set_on_trapeze_with_name_matching_expected_pattern
      Trapeze.expects(:const_set).with do |name, value|
        name =~ /^Sandbox\d{1,4}$/
      end
      Trapeze::Sandbox.create
    end
    
    def test_should_call_const_set_on_trapeze_with_module
      Trapeze.expects(:const_set).with do |name, value|
        value.instance_of? Module
      end
      Trapeze::Sandbox.create
    end
    
    def test_should_return_result_of_call_to_const_set
      assert_equal :stubbed_module, Trapeze::Sandbox.create
    end
    
  end
  
  class StripFromTypeName < Test::Unit::TestCase
    
    def test_should_call_name_on_arg
      mock_type = mock('type')
      mock_type.expects(:name).returns stub_everything
      Trapeze::Sandbox.strip_from_type_name mock_type
    end
    
    def test_should_return_name_of_arg_stripped_of_sandbox_prefix
      mock_type = mock('type')
      mock_type.stubs(:name).returns 'Trapeze::Sandbox9999::Foo'
      assert_equal 'Foo', Trapeze::Sandbox.strip_from_type_name(mock_type)
    end
    
    def test_should_return_name_of_arg_unchanged_if_lacking_sandbox_prefix
      mock_type = mock('type')
      mock_type.stubs(:name).returns 'Foo::Bar::Baz'
      assert_equal 'Foo::Bar::Baz',
                   Trapeze::Sandbox.strip_from_type_name(mock_type)
    end
    
  end
  
end

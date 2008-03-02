require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/empty_dir_extension")
require 'test/unit'
require 'rubygems'
require 'mocha'

module Trapeze::EmptyDirExtensionTest
  
  class Klass < Test::Unit::TestCase
    
    def setup
      Dir.stubs(:system).returns true
    end
    
    def test_should_call_windows_osQUESTION_when_sent_empty_dirEXCLAMATION
      Dir.expects(:windows_os?).returns false
      Dir.empty_dir! 'foo'
    end
    
    def test_should_return_self_when_sent_empty_dirEXCLAMATION
      Dir.stubs(:windows_os?).returns false
      assert_equal Dir, Dir.empty_dir!('foo')
    end
    
    if RUBY_PLATFORM =~ /mswin/
      def test_should_return_true_when_sent_windows_osQUESTION_because_these_tests_are_running_on_windows
        assert_equal true, Dir.send('windows_os?')
      end
    else
      def test_should_return_false_when_sent_windows_osQUESTION_because_these_tests_are_not_running_on_windows
        assert_equal false, Dir.send('windows_os?')
      end
    end
    
  end
  
  class UnderWindowsOS < Test::Unit::TestCase
    
    def setup
      Dir.stubs(:windows_os?).returns true
    end
    
    def test_should_call_system_with_expected_windows_remove_dir_command_when_sent_empty_dirEXCLAMATION_with_path
      Dir.expects(:system).with('rmdir /q /s "foo"').returns true
      Dir.stubs(:system).with('mkdir "foo"').returns true
      Dir.empty_dir! 'foo'
    end
    
    def test_should_raise_runtime_error_when_removing_dir_fails_upon_sending_empty_dirEXCLAMATION_with_path
      Dir.stubs(:system).with('rmdir /q /s "foo"').returns false
      assert_raise(RuntimeError) { Dir.empty_dir! 'foo' }
    end
    
    def test_should_call_system_with_expected_windows_create_dir_command_when_sent_empty_dirEXCLAMATION_with_path
      Dir.stubs(:system).with('rmdir /q /s "foo"').returns true
      Dir.expects(:system).with('mkdir "foo"').returns true
      Dir.empty_dir! 'foo'
    end
    
    def test_should_raise_runtime_error_when_creating_dir_fails_upon_sending_empty_dirEXCLAMATION_with_path
      Dir.stubs(:system).with('rmdir /q /s "foo"').returns true
      Dir.stubs(:system).with('mkdir "foo"').returns false
      assert_raise(RuntimeError) { Dir.empty_dir! 'foo' }
    end
    
  end
  
  class UnderOtherOS < Test::Unit::TestCase
    
    def setup
      Dir.stubs(:windows_os?).returns false
    end
    
    def test_should_call_system_with_expected_unix_remove_dir_command_when_sent_empty_dirEXCLAMATION_with_path
      Dir.expects(:system).with('rm -fr "foo"').returns true
      Dir.stubs(:system).with('mkdir "foo"').returns true
      Dir.empty_dir! 'foo'
    end
    
    def test_should_raise_runtime_error_when_removing_dir_fails_upon_sending_empty_dirEXCLAMATION_with_path
      Dir.stubs(:system).with('rm -fr "foo"').returns false
      assert_raise(RuntimeError) { Dir.empty_dir! 'foo' }
    end
    
    def test_should_call_system_with_expected_unix_create_dir_command_when_sent_empty_dirEXCLAMATION_with_path
      Dir.stubs(:system).with('rm -fr "foo"').returns true
      Dir.expects(:system).with('mkdir "foo"').returns true
      Dir.empty_dir! 'foo'
    end
    
    def test_should_raise_runtime_error_when_creating_dir_fails_upon_sending_empty_dirEXCLAMATION_with_path
      Dir.stubs(:system).with('rm -fr "foo"').returns true
      Dir.stubs(:system).with('mkdir "foo"').returns false
      assert_raise(RuntimeError) { Dir.empty_dir! 'foo' }
    end
    
  end
  
end

require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/loader")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/../assertion_helpers_extension")
require 'rubygems'
require 'mocha'

module Trapeze::LoaderTest
  
  class WithNoFilenames < Test::Unit::TestCase
    
    def setup
      @loader = Trapeze::Loader.new
      File.stubs(:read).returns ''
      @loader.stubs(:unsandbox!).returns stub_everything
      @loader.stubs(:constantize).returns stub_everything
    end
    
    def test_should_return_empty_array_when_sent_filenames
      assert_equal [], @loader.filenames
    end
    
    def test_should_not_call_file_read_when_sent_loadEXCLAMATION
      File.expects(:read).never.returns ''
      @loader.load!
    end
    
    def test_should_return_empty_array_when_sent_classes
      assert_equal [], @loader.classes
    end
    
    def test_should_return_empty_array_when_sent_modules
      assert_equal [], @loader.modules
    end
    
    def test_should_return_empty_array_when_sent_top_level_methods
      assert_equal [], @loader.top_level_methods
    end
    
    def test_should_return_empty_array_when_sent_exceptions
      assert_equal [], @loader.exceptions
    end
    
  end
  
  module WithOneFilename
    
    class DefiningNothing < Test::Unit::TestCase
      
      def setup
        @loader = Trapeze::Loader.new('empty.rb')
        File.stubs(:read).returns ''
        @loader.stubs(:unsandbox!).returns stub_everything
        @loader.stubs(:constantize).returns stub_everything
      end
      
      def test_should_return_array_of_expected_filenames_when_sent_filenames
        assert_equal ['empty.rb'], @loader.filenames
      end
      
      def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
        File.expects(:read).with('empty.rb').returns ''
        @loader.load!
        @loader.load!
      end
      
      def test_should_return_self_when_sent_loadEXCLAMATION
        assert_equal @loader, @loader.load!
      end
      
      def test_should_call_file_read_once_when_sent_classes_twice
        File.expects(:read).with('empty.rb').returns ''
        @loader.classes
        @loader.classes
      end
      
      def test_should_return_empty_array_when_sent_classes
        assert_equal [], @loader.classes
      end
      
      def test_should_call_file_read_once_when_sent_modules_twice
        File.expects(:read).with('empty.rb').returns ''
        @loader.modules
        @loader.modules
      end
      
      def test_should_return_empty_array_when_sent_modules
        assert_equal [], @loader.modules
      end
      
      def test_should_call_file_read_once_when_sent_top_level_methods_twice
        File.expects(:read).with('empty.rb').returns ''
        @loader.top_level_methods
        @loader.top_level_methods
      end
      
      def test_should_return_empty_array_when_sent_top_level_methods
        assert_equal [], @loader.top_level_methods
      end
      
      def test_should_return_empty_array_when_sent_exceptions
        assert_equal [], @loader.exceptions
      end
      
    end
    
    module DefiningClasses
      
      class MethodlessClasses < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            class FooClass; end
            class BarClass; end
          end_source
          @loader = Trapeze::Loader.new('methodless_classes.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything(:class => Class)
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['methodless_classes.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('methodless_classes.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('methodless_classes.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_array_of_expected_classes_when_sent_classes
          foo_class = stub('FooClass', :class => Class,
                                       :_defined_methods => [],
                                       :_defined_instance_methods => [])
          @loader.stubs(:constantize).with('FooClass').returns foo_class
          bar_class = stub('BarClass', :class => Class,
                                       :_defined_methods => [],
                                       :_defined_instance_methods => [])
          @loader.stubs(:constantize).with('BarClass').returns bar_class
          expected = {foo_class => {}, bar_class => {}}
          assert_classes expected, @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('methodless_classes.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_empty_array_when_sent_modules
          assert_equal [], @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('methodless_classes.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_top_level_methods
          assert_equal [], @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
      class ClassesWithMetaclassMethods < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            class FooClass
              class << self
                def bar; end
                def baz; end
              end
            end
            class BatClass
              class << self
                def pwop; end
                def ding; end
              end
            end
          end_source
          @loader = Trapeze::Loader.new('classes_with_metaclass_methods.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything(:class => Class)
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['classes_with_metaclass_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('classes_with_metaclass_methods.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('classes_with_metaclass_methods.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_array_of_expected_classes_when_sent_classes
          foo_class = stub('FooClass', :class => Class,
                                       :_defined_methods => %w(bar baz),
                                       :_defined_instance_methods => [])
          @loader.stubs(:constantize).with('FooClass').returns foo_class
          bat_class = stub('BatClass', :class => Class,
                                       :_defined_methods => %w(ding pwop),
                                       :_defined_instance_methods => [])
          @loader.stubs(:constantize).with('BatClass').returns bat_class
          expected = {foo_class => {:class_methods => %w(bar baz)},
                      bat_class => {:class_methods => %w(ding pwop)}}
          assert_classes expected, @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('classes_with_metaclass_methods.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_empty_array_when_sent_modules
          assert_equal [], @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('classes_with_metaclass_methods.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_top_level_methods
          assert_equal [], @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
      class ClassesWithClassMethods < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            class FooClass
              def self.bar; end
              def self.baz; end
            end
            class BatClass
              def self.pwop; end
              def self.ding; end
            end
          end_source
          @loader = Trapeze::Loader.new('classes_with_class_methods.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything(:class => Class)
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['classes_with_class_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('classes_with_class_methods.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('classes_with_class_methods.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_array_of_expected_classes_when_sent_classes
          foo_class = stub('FooClass', :class => Class,
                                       :_defined_methods => %w(bar baz),
                                       :_defined_instance_methods => [])
          @loader.stubs(:constantize).with('FooClass').returns foo_class
          bat_class = stub('BatClass', :class => Class,
                                       :_defined_methods => %w(ding pwop),
                                       :_defined_instance_methods => [])
          @loader.stubs(:constantize).with('BatClass').returns bat_class
          expected = {foo_class => {:class_methods => %w(bar baz)},
                      bat_class => {:class_methods => %w(ding pwop)}}
          assert_classes expected, @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('classes_with_class_methods.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_empty_array_when_sent_modules
          assert_equal [], @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('classes_with_class_methods.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_top_level_methods
          assert_equal [], @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
      class ClassesWithInstanceMethods < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            class FooClass
              def bar; end
              def baz; end
            end
            class BatClass
              def pwop; end
              def ding; end
            end
          end_source
          @loader = Trapeze::Loader.new('classes_with_instance_methods.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything(:class => Class)
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['classes_with_instance_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('classes_with_instance_methods.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('classes_with_instance_methods.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_array_of_expected_classes_when_sent_classes
          foo_class = stub('FooClass', :class => Class,
                                       :_defined_methods => [],
                                       :_defined_instance_methods => %w(bar
                                                                        baz))
          @loader.stubs(:constantize).with('FooClass').returns foo_class
          bat_class = stub('BatClass', :class => Class,
                                       :_defined_methods => [],
                                       :_defined_instance_methods => %w(ding
                                                                        pwop))
          @loader.stubs(:constantize).with('BatClass').returns bat_class
          expected = {foo_class => {:instance_methods => %w(bar baz)},
                      bat_class => {:instance_methods => %w(ding pwop)}}
          assert_classes expected, @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('classes_with_instance_methods.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_empty_array_when_sent_modules
          assert_equal [], @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('classes_with_instance_methods.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_top_level_methods
          assert_equal [], @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
      class ClassesWithMetaclassMethodsAndClassMethodsAndInstanceMethods < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            class FooClass
              class << self
                def fizz; end
                def fuzz; end
              end
              def self.bar; end
              def self.baz; end
              def bat; end
              def pwop; end
            end
            class DingClass
              class << self
                def biz; end
                def buzz; end
              end
              def self.doot; end
              def self.deet; end
              def dit; end
              def dot; end
            end
          end_source
          @loader = Trapeze::Loader.new('classes_with_metaclass_methods_and_class_methods_and_instance_methods.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything(:class => Class)
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['classes_with_metaclass_methods_and_class_methods_and_instance_methods.rb'],
                       @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('classes_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('classes_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_array_of_expected_classes_when_sent_classes
          foo_class = stub('FooClass', :class => Class,
                                       :_defined_methods => %w(bar
                                                               baz
                                                               fizz
                                                               fuzz),
                                       :_defined_instance_methods => %w(bat
                                                                        pwop))
          @loader.stubs(:constantize).with('FooClass').returns foo_class
          ding_class = stub('DingClass', :class => Class,
                                         :_defined_methods => %w(biz
                                                                 buzz
                                                                 deet
                                                                 doot),
                                         :_defined_instance_methods => %w(dit
                                                                          dot))
          @loader.stubs(:constantize).with('DingClass').returns ding_class
          expected = {foo_class => {:class_methods => %w(bar baz fizz fuzz),
                                    :instance_methods => %w(bat pwop)},
                      ding_class => {:class_methods => %w(biz buzz deet doot),
                                     :instance_methods => %w(dit dot)}}
          assert_classes expected, @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('classes_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_empty_array_when_sent_modules
          assert_equal [], @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('classes_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_top_level_methods
          assert_equal [], @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
    end
    
    module DefiningModules
      
      class MethodlessModules < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            module FooModule; end
            module BarModule; end
          end_source
          @loader = Trapeze::Loader.new('methodless_modules.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything(:class => Module)
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['methodless_modules.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('methodless_modules.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('methodless_modules.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_empty_array_when_sent_when_sent_classes
          assert_equal [], @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('methodless_modules.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_array_of_expected_modules_when_sent_modules
          foo_module = stub('FooModule', :class => Module,
                                         :_defined_methods => [],
                                         :_defined_instance_methods => [])
          @loader.stubs(:constantize).with('FooModule').returns foo_module
          bar_module = stub('BarModule', :class => Module,
                                         :_defined_methods => [],
                                         :_defined_instance_methods => [])
          @loader.stubs(:constantize).with('BarModule').returns bar_module
          expected = {foo_module => {}, bar_module => {}}
          assert_modules expected, @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('methodless_modules.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_top_level_methods
          assert_equal [], @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
      class ModulesWithMetaclassMethods < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            module FooModule
              class << self
                def bar; end
                def baz; end
              end
            end
            module BatModule
              class << self
                def pwop; end
                def ding; end
              end
            end
          end_source
          @loader = Trapeze::Loader.new('modules_with_metaclass_methods.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything(:class => Module)
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['modules_with_metaclass_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('modules_with_metaclass_methods.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('modules_with_metaclass_methods.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_empty_array_when_sent_classes
          assert_equal [], @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('modules_with_metaclass_methods.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_array_of_expected_modules_when_sent_modules
          foo_module = stub('FooModule', :class => Module,
                                         :_defined_methods => %w(bar baz),
                                         :_defined_instance_methods => [])
          @loader.stubs(:constantize).with('FooModule').returns foo_module
          bat_module = stub('BatModule', :class => Module,
                                         :_defined_methods => %w(ding pwop),
                                         :_defined_instance_methods => [])
          @loader.stubs(:constantize).with('BatModule').returns bat_module
          expected = {foo_module => {:module_methods => %w(bar baz)},
                      bat_module => {:module_methods => %w(ding pwop)}}
          assert_modules expected, @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('modules_with_metaclass_methods.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_top_level_methods
          assert_equal [], @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
      class ModulesWithModuleMethods < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            module FooModule
              def self.bar; end
              def self.baz; end
            end
            module BatModule
              def self.pwop; end
              def self.ding; end
            end
          end_source
          @loader = Trapeze::Loader.new('modules_with_class_methods.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything(:class => Module)
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['modules_with_class_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('modules_with_class_methods.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('modules_with_class_methods.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_empty_array_when_sent_classes
          assert_equal [], @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('modules_with_class_methods.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_array_of_expected_modules_when_sent_modules
          foo_module = stub('FooModule', :class => Module,
                                         :_defined_methods => %w(bar baz),
                                         :_defined_instance_methods => [])
          @loader.stubs(:constantize).with('FooModule').returns foo_module
          bat_module = stub('BatModule', :class => Module,
                                         :_defined_methods => %w(ding pwop),
                                         :_defined_instance_methods => [])
          @loader.stubs(:constantize).with('BatModule').returns bat_module
          expected = {foo_module => {:module_methods => %w(bar baz)},
                      bat_module => {:module_methods => %w(ding pwop)}}
          assert_modules expected, @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('modules_with_class_methods.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_top_level_methods
          assert_equal [], @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
      class ModulesWithInstanceMethods < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            module FooModule
              def bar; end
              def baz; end
            end
            module BatModule
              def pwop; end
              def ding; end
            end
          end_source
          @loader = Trapeze::Loader.new('modules_with_instance_methods.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything(:class => Module)
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['modules_with_instance_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('modules_with_instance_methods.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('modules_with_instance_methods.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_empty_array_when_sent_classes
          assert_equal [], @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('modules_with_instance_methods.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_array_of_expected_modules_when_sent_modules
          foo_module = stub('FooModule', :class => Module,
                                         :_defined_methods => [],
                                         :_defined_instance_methods => %w(bar
                                                                          baz))
          @loader.stubs(:constantize).with('FooModule').returns foo_module
          bat_module = stub('BatModule', :class => Module,
                                         :_defined_methods => [],
                                         :_defined_instance_methods => %w(ding
                                                                          pwop))
          @loader.stubs(:constantize).with('BatModule').returns bat_module
          expected = {foo_module => {:instance_methods => %w(bar baz)},
                      bat_module => {:instance_methods => %w(ding pwop)}}
          assert_modules expected, @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('modules_with_instance_methods.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_top_level_methods
          assert_equal [], @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
      class ModulesWithMetaclassMethodsAndClassMethodsAndInstanceMethods < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            module FooModule
              class << self
                def fizz; end
                def fuzz; end
              end
              def self.bar; end
              def self.baz; end
              def bat; end
              def pwop; end
            end
            module DingModule
              class << self
                def biz; end
                def buzz; end
              end
              def self.doot; end
              def self.deet; end
              def dit; end
              def dot; end
            end
          end_source
          @loader = Trapeze::Loader.new('modules_with_metaclass_methods_and_class_methods_and_instance_methods.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything(:class => Module)
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['modules_with_metaclass_methods_and_class_methods_and_instance_methods.rb'],
                       @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('modules_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('modules_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_empty_array_when_sent_classes
          assert_equal [], @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('modules_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_array_of_expected_modules_when_sent_modules
          foo_module = stub('FooModule', :class => Module,
                                         :_defined_methods => %w(bar
                                                                 baz
                                                                 fizz
                                                                 fuzz),
                                         :_defined_instance_methods => %w(bat
                                                                          pwop))
          @loader.stubs(:constantize).with('FooModule').returns foo_module
          ding_module = stub('DingModule', :class => Module,
                                         :_defined_methods => %w(biz
                                                                 buzz
                                                                 deet
                                                                 doot),
                                         :_defined_instance_methods => %w(dit
                                                                          dot))
          @loader.stubs(:constantize).with('DingModule').returns ding_module
          expected = {foo_module => {:module_methods => %w(bar baz fizz fuzz),
                                     :instance_methods => %w(bat pwop)},
                      ding_module => {:module_methods => %w(biz buzz deet doot),
                                      :instance_methods => %w(dit dot)}}
          assert_modules expected, @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('modules_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_top_level_methods
          assert_equal [], @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
    end
    
    module DefiningMethods
      
      class MetaclassMethods < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            class << self
              def foo; end
              def bar; end
            end
          end_source
          @loader = Trapeze::Loader.new('metaclass_methods.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['metaclass_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('metaclass_methods.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('metaclass_methods.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_empty_array_when_sent_classes
          assert_equal [], @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('metaclass_methods.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_empty_array_when_sent_modules
          assert_equal [], @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('metaclass_methods.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_array_of_expected_methods_when_sent_top_level_methods
          expected = %w(bar foo)
          assert_equal expected, @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
      class ClassMethods < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            def self.foo; end
            def self.bar; end
          end_source
          @loader = Trapeze::Loader.new('class_methods.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['class_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('class_methods.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('class_methods.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_empty_array_when_sent_classes
          assert_equal [], @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('class_methods.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_empty_array_when_sent_modules
          assert_equal [], @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('class_methods.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_array_of_expected_methods_when_sent_top_level_methods
          expected = %w(bar foo)
          assert_equal expected, @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
      class InstanceMethods < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            def foo; end
            def bar; end
          end_source
          @loader = Trapeze::Loader.new('instance_methods.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['instance_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('instance_methods.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('instance_methods.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_empty_array_when_sent_classes
          assert_equal [], @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('instance_methods.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_empty_array_when_sent_modules
          assert_equal [], @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('instance_methods.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_array_of_expected_methods_when_sent_top_level_methods
          expected = %w(bar foo)
          assert_equal expected, @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
      class MetaclassMethodsAndClassMethodsAndInstanceMethods < Test::Unit::TestCase
        
        def setup
          @source =<<-end_source
            class << self
              def foo; end
              def bar; end
            end
            def self.baz; end
            def self.bat; end
            def pwop; end
            def ding; end
          end_source
          @loader = Trapeze::Loader.new('metaclass_methods_and_class_methods_and_instance_methods.rb')
          File.stubs(:read).returns @source
          @loader.stubs(:unsandbox!).returns stub_everything
          @loader.stubs(:constantize).returns stub_everything
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['metaclass_methods_and_class_methods_and_instance_methods.rb'],
                       @loader.filenames
        end
        
        def test_should_call_file_read_once_when_sent_loadEXCLAMATION_twice
          File.expects(:read).with('metaclass_methods_and_class_methods_and_instance_methods.rb').returns ''
          @loader.load!
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_classes_twice
          File.expects(:read).with('metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.classes
          @loader.classes
        end
        
        def test_should_return_empty_array_when_sent_classes
          assert_equal [], @loader.classes
        end
        
        def test_should_call_file_read_once_when_sent_modules_twice
          File.expects(:read).with('metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.modules
          @loader.modules
        end
        
        def test_should_return_empty_array_when_sent_modules
          assert_equal [], @loader.modules
        end
        
        def test_should_call_file_read_once_when_sent_top_level_methods_twice
          File.expects(:read).with('metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.top_level_methods
          @loader.top_level_methods
        end
        
        def test_should_return_array_of_expected_methods_when_sent_top_level_methods
          expected = %w(bar bat baz ding foo pwop)
          assert_equal expected, @loader.top_level_methods
        end
        
        def test_should_return_empty_array_when_sent_exceptions
          assert_equal [], @loader.exceptions
        end
        
      end
      
    end
    
  end
  
end

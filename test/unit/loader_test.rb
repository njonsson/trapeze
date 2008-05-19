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
    end
    
    def test_should_return_empty_array_when_sent_filenames
      assert_equal [], @loader.filenames
    end
    
    def test_should_return_empty_array_when_sent_class_definitions
      assert_equal [], @loader.class_definitions
    end
    
    def test_should_return_empty_array_when_sent_module_definitions
      assert_equal [], @loader.module_definitions
    end
    
    def test_should_return_empty_array_when_sent_method_definitions
      assert_equal [], @loader.method_definitions
    end
    
  end
  
  module WithOneFilename
    
    class DefiningNothing < Test::Unit::TestCase
      
      def setup
        @loader = Trapeze::Loader.new('empty.rb')
        File.stubs(:read).returns ''
      end
      
      def test_should_return_array_of_expected_filenames_when_sent_filenames
        assert_equal ['empty.rb'], @loader.filenames
      end
      
      def test_should_call_file_read_when_sent_loadEXCLAMATION
        File.expects(:read).with('empty.rb').returns ''
        @loader.load!
      end
      
      def test_should_return_self_when_sent_loadEXCLAMATION
        assert_equal @loader, @loader.load!
      end
      
      def test_should_call_file_read_once_when_sent_class_definitions_twice
        File.expects(:read).with('empty.rb').returns ''
        @loader.class_definitions
        @loader.class_definitions
      end
      
      def test_should_return_empty_array_when_sent_class_definitions
        assert_equal [], @loader.class_definitions
      end
      
      def test_should_call_file_read_once_when_sent_module_definitions_twice
        File.expects(:read).with('empty.rb').returns ''
        @loader.module_definitions
        @loader.module_definitions
      end
      
      def test_should_return_empty_array_when_sent_module_definitions
        assert_equal [], @loader.module_definitions
      end
      
      def test_should_call_file_read_once_when_sent_method_definitions_twice
        File.expects(:read).with('empty.rb').returns ''
        @loader.method_definitions
        @loader.method_definitions
      end
      
      def test_should_return_empty_array_when_sent_method_definitions
        assert_equal [], @loader.method_definitions
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['methodless_classes.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('methodless_classes.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('methodless_classes.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_array_of_expected_class_definitions_when_sent_class_definitions
          expected = {'FooClass' => {}, 'BarClass' => {}}
          assert_classes expected, @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('methodless_classes.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_empty_array_when_sent_module_definitions
          assert_equal [], @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('methodless_classes.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_empty_array_when_sent_method_definitions
          assert_equal [], @loader.method_definitions
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['classes_with_metaclass_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('classes_with_metaclass_methods.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('classes_with_metaclass_methods.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_array_of_expected_class_definitions_when_sent_class_definitions
          expected = {'FooClass' => {:class_methods => [['bar', {:arity => 0}],
                                                        ['baz', {:arity => 0}]]},
                      'BatClass' => {:class_methods => [['ding', {:arity => 0}],
                                                        ['pwop', {:arity => 0}]]}}
          assert_classes expected, @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('classes_with_metaclass_methods.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_empty_array_when_sent_module_definitions
          assert_equal [], @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('classes_with_metaclass_methods.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_empty_array_when_sent_method_definitions
          assert_equal [], @loader.method_definitions
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['classes_with_class_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('classes_with_class_methods.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('classes_with_class_methods.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_array_of_expected_class_definitions_when_sent_class_definitions
          expected = {'FooClass' => {:class_methods => [['bar', {:arity => 0}],
                                                        ['baz', {:arity => 0}]]},
                      'BatClass' => {:class_methods => [['ding', {:arity => 0}],
                                                        ['pwop', {:arity => 0}]]}}
          assert_classes expected, @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('classes_with_class_methods.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_empty_array_when_sent_module_definitions
          assert_equal [], @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('classes_with_class_methods.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_empty_array_when_sent_method_definitions
          assert_equal [], @loader.method_definitions
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['classes_with_instance_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('classes_with_instance_methods.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('classes_with_instance_methods.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_array_of_expected_class_definitions_when_sent_class_definitions
          expected = {'FooClass' => {:instance_methods => [['bar', {:arity => 0}],
                                                           ['baz', {:arity => 0}]]},
                      'BatClass' => {:instance_methods => [['ding', {:arity => 0}],
                                                           ['pwop', {:arity => 0}]]}}
          assert_classes expected, @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('classes_with_instance_methods.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_empty_array_when_sent_module_definitions
          assert_equal [], @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('classes_with_instance_methods.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_empty_array_when_sent_method_definitions
          assert_equal [], @loader.method_definitions
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['classes_with_metaclass_methods_and_class_methods_and_instance_methods.rb'],
                       @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('classes_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('classes_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_array_of_expected_class_definitions_when_sent_class_definitions
          expected = {'FooClass' => {:class_methods => [['bar', {:arity => 0}],
                                                        ['baz', {:arity => 0}],
                                                        ['fizz', {:arity => 0}],
                                                        ['fuzz', {:arity => 0}]],
                                     :instance_methods => [['bat', {:arity => 0}],
                                                           ['pwop', {:arity => 0}]]},
                      'DingClass' => {:class_methods => [['biz', {:arity => 0}],
                                                         ['buzz', {:arity => 0}],
                                                         ['deet', {:arity => 0}],
                                                         ['doot', {:arity => 0}]],
                                      :instance_methods => [['dit', {:arity => 0}],
                                                            ['dot', {:arity => 0}]]}}
          assert_classes expected, @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('classes_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_empty_array_when_sent_module_definitions
          assert_equal [], @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('classes_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_empty_array_when_sent_method_definitions
          assert_equal [], @loader.method_definitions
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['methodless_modules.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('methodless_modules.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('methodless_modules.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_empty_array_when_sent_when_sent_class_definitions
          assert_equal [], @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('methodless_modules.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_array_of_expected_module_definitions_when_sent_module_definitions
          expected = {'FooModule' => {}, 'BarModule' => {}}
          assert_modules expected, @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('methodless_modules.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_empty_array_when_sent_method_definitions
          assert_equal [], @loader.method_definitions
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['modules_with_metaclass_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('modules_with_metaclass_methods.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('modules_with_metaclass_methods.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_empty_array_when_sent_class_definitions
          assert_equal [], @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('modules_with_metaclass_methods.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_array_of_expected_module_definitions_when_sent_module_definitions
          expected = {'FooModule' => {:class_methods => [['bar', {:arity => 0}],
                                                         ['baz', {:arity => 0}]]},
                      'BatModule' => {:class_methods => [['ding', {:arity => 0}],
                                                         ['pwop', {:arity => 0}]]}}
          assert_modules expected, @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('modules_with_metaclass_methods.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_empty_array_when_sent_method_definitions
          assert_equal [], @loader.method_definitions
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['modules_with_class_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('modules_with_class_methods.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('modules_with_class_methods.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_empty_array_when_sent_class_definitions
          assert_equal [], @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('modules_with_class_methods.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_array_of_expected_module_definitions_when_sent_module_definitions
          File.stubs(:read).returns @source
          expected = {'FooModule' => {:class_methods => [['bar', {:arity => 0}],
                                                         ['baz', {:arity => 0}]]},
                      'BatModule' => {:class_methods => [['ding', {:arity => 0}],
                                                         ['pwop', {:arity => 0}]]}}
          assert_modules expected, @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('modules_with_class_methods.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_empty_array_when_sent_method_definitions
          assert_equal [], @loader.method_definitions
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['modules_with_instance_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('modules_with_instance_methods.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('modules_with_instance_methods.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_empty_array_when_sent_class_definitions
          assert_equal [], @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('modules_with_instance_methods.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_array_of_expected_module_definitions_when_sent_module_definitions
          expected = {'FooModule' => {:instance_methods => [['bar', {:arity => 0}],
                                                            ['baz', {:arity => 0}]]},
                      'BatModule' => {:instance_methods => [['ding', {:arity => 0}],
                                                            ['pwop', {:arity => 0}]]}}
          assert_modules expected, @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('modules_with_instance_methods.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_empty_array_when_sent_method_definitions
          assert_equal [], @loader.method_definitions
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['modules_with_metaclass_methods_and_class_methods_and_instance_methods.rb'],
                       @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('modules_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('modules_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_empty_array_when_sent_class_definitions
          assert_equal [], @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('modules_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_array_of_expected_module_definitions_when_sent_module_definitions
          expected = {'FooModule' => {:class_methods => [['bar', {:arity => 0}],
                                                         ['baz', {:arity => 0}],
                                                         ['fizz', {:arity => 0}],
                                                         ['fuzz', {:arity => 0}]],
                                      :instance_methods => [['bat', {:arity => 0}],
                                                            ['pwop', {:arity => 0}]]},
                      'DingModule' => {:class_methods => [['biz', {:arity => 0}],
                                                          ['buzz', {:arity => 0}],
                                                          ['deet', {:arity => 0}],
                                                          ['doot', {:arity => 0}]],
                                       :instance_methods => [['dit', {:arity => 0}],
                                                             ['dot', {:arity => 0}]]}}
          assert_modules expected, @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('modules_with_metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_empty_array_when_sent_method_definitions
          assert_equal [], @loader.method_definitions
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['metaclass_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('metaclass_methods.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('metaclass_methods.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_empty_array_when_sent_class_definitions
          assert_equal [], @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('metaclass_methods.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_empty_array_when_sent_module_definitions
          assert_equal [], @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('metaclass_methods.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_empty_array_when_sent_method_definitions
          assert_equal [], @loader.method_definitions
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['class_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('class_methods.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('class_methods.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_empty_array_when_sent_class_definitions
          assert_equal [], @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('class_methods.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_empty_array_when_sent_module_definitions
          assert_equal [], @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('class_methods.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_empty_array_when_sent_method_definitions
          assert_equal [], @loader.method_definitions
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['instance_methods.rb'], @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('instance_methods.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('instance_methods.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_empty_array_when_sent_class_definitions
          assert_equal [], @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('instance_methods.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_empty_array_when_sent_module_definitions
          assert_equal [], @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('instance_methods.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_array_of_expected_method_definitions_when_sent_method_definitions
          expected = [['bar', {:arity => 0}], ['foo', {:arity => 0}]]
          assert_methods(expected, @loader.method_definitions)
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
        end
        
        def test_should_return_array_of_expected_filenames_when_sent_filenames
          assert_equal ['metaclass_methods_and_class_methods_and_instance_methods.rb'],
                       @loader.filenames
        end
        
        def test_should_call_file_read_when_sent_loadEXCLAMATION
          File.expects(:read).with('metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.load!
        end
        
        def test_should_return_self_when_sent_loadEXCLAMATION
          assert_equal @loader, @loader.load!
        end
        
        def test_should_call_file_read_once_when_sent_class_definitions_twice
          File.expects(:read).with('metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.class_definitions
          @loader.class_definitions
        end
        
        def test_should_return_empty_array_when_sent_class_definitions
          assert_equal [], @loader.class_definitions
        end
        
        def test_should_call_file_read_once_when_sent_module_definitions_twice
          File.expects(:read).with('metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.module_definitions
          @loader.module_definitions
        end
        
        def test_should_return_empty_array_when_sent_module_definitions
          assert_equal [], @loader.module_definitions
        end
        
        def test_should_call_file_read_once_when_sent_method_definitions_twice
          File.expects(:read).with('metaclass_methods_and_class_methods_and_instance_methods.rb').returns @source
          @loader.method_definitions
          @loader.method_definitions
        end
        
        def test_should_return_array_of_expected_method_definitions_when_sent_method_definitions
          expected = [['ding', {:arity => 0}], ['pwop', {:arity => 0}]]
          assert_methods(expected, @loader.method_definitions)
        end
        
      end
      
    end
    
  end
  
end

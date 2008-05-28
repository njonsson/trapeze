require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/probe")
require 'test/unit'
require 'rubygems'
require 'mocha'
require File.expand_path("#{File.dirname __FILE__}/../assertion_helpers_extension")

module Trapeze::ProbeTest
  
  class WithEmptyLoader < Test::Unit::TestCase
    
    def setup
      @mock_loader = mock
      @mock_loader.stubs(:classes).returns []
      @mock_loader.stubs(:modules).returns []
      @mock_loader.stubs(:top_level_methods).returns []
      @probe = Trapeze::Probe.new(@mock_loader)
    end
    
    def test_should_return_expected_object_when_sent_loader
      assert_equal @mock_loader, @probe.loader
    end
    
    def test_should_return_self_when_sent_probeEXCLAMATION
      assert_equal @probe, @probe.probe!
    end
    
    def test_should_return_empty_hash_when_sent_class_probe_results
      assert_equal [], @probe.class_probe_results
    end
    
    def test_should_call_loader_loadEXCLAMATION_once_when_sent_class_probe_results_twice
      @mock_loader.expects(:classes).returns []
      @mock_loader.expects(:modules).returns []
      @mock_loader.expects(:top_level_methods).returns []
      @probe.class_probe_results
      @probe.class_probe_results
    end
    
    def test_should_return_empty_hash_when_sent_module_probe_results
      assert_equal [], @probe.module_probe_results
    end
    
    def test_should_call_loader_loadEXCLAMATION_once_when_sent_module_probe_results_twice
      @mock_loader.expects(:classes).returns []
      @mock_loader.expects(:modules).returns []
      @mock_loader.expects(:top_level_methods).returns []
      @probe.module_probe_results
      @probe.module_probe_results
    end
    
    def test_should_return_empty_array_when_sent_top_level_method_probe_results
      assert_equal [], @probe.top_level_method_probe_results
    end
    
    def test_should_call_loader_loadEXCLAMATION_once_when_sent_top_level_method_probe_results_twice
      @mock_loader.expects(:classes).returns []
      @mock_loader.expects(:modules).returns []
      @mock_loader.expects(:top_level_methods).returns []
      @probe.top_level_method_probe_results
      @probe.top_level_method_probe_results
    end
    
  end
  
  module WithLoaderHavingClasses
    
    class MethodlessClasses < Test::Unit::TestCase
      
      class FooClass; end
      
      class BarClass; end
      
      def setup
        @classes = [FooClass, BarClass]
        FooClass.stubs(:_defined_methods).returns []
        FooClass.stubs(:_defined_instance_methods).returns []
        BarClass.stubs(:_defined_methods).returns []
        BarClass.stubs(:_defined_instance_methods).returns []
        @mock_loader = mock
        @mock_loader.stubs(:classes).returns @classes
        @mock_loader.stubs(:modules).returns []
        @mock_loader.stubs(:top_level_methods).returns []
        @probe = Trapeze::Probe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_probeEXCLAMATION
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_class_probe_results
        expected = [{:class => FooClass}, {:class => BarClass}]
        assert_probe_results expected, @probe.class_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_top_level_method_probe_results
        assert_equal [], @probe.top_level_method_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_top_level_method_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.top_level_method_probe_results
        @probe.top_level_method_probe_results
      end
      
    end
    
    class ClassesWithArglessMetaclassMethodsThatDoNothing < Test::Unit::TestCase
      
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
      
      def setup
        @classes = [FooClass, BatClass]
        FooClass.stubs(:_defined_methods).returns %w(bar baz)
        FooClass.stubs(:_defined_instance_methods).returns []
        BatClass.stubs(:_defined_methods).returns %w(ding pwop)
        BatClass.stubs(:_defined_instance_methods).returns []
        @mock_loader = mock
        @mock_loader.stubs(:classes).returns @classes
        @mock_loader.stubs(:modules).returns []
        @mock_loader.stubs(:top_level_methods).returns []
        @probe = Trapeze::Probe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_probeEXCLAMATION
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_class_probe_results
        expected = [{:class => FooClass,
                     :class_method_probings => [{:method_name => 'bar',
                                                 :returned => nil},
                                                {:method_name => 'baz',
                                                 :returned => nil}]},
                    {:class => BatClass,
                     :class_method_probings => [{:method_name => 'ding',
                                                 :returned => nil},
                                                {:method_name => 'pwop',
                                                 :returned => nil}]}]
        assert_probe_results expected, @probe.class_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_top_level_method_probe_results
        assert_equal [], @probe.top_level_method_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_top_level_method_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.top_level_method_probe_results
        @probe.top_level_method_probe_results
      end
      
    end
    
    class ClassesWithOneArgMetaclassMethodsThatDoNothing < Test::Unit::TestCase
      
      class FooClass
        
        class << self
          
          def bar(baz); end
          
          def bat(pwop); end
          
        end
        
      end
      
      class DingClass
        
        class << self
          
          def doot(deet); end
          
          def dit(dot); end
          
        end
        
      end
      
      def setup
        @classes = [FooClass, DingClass]
        FooClass.stubs(:_defined_methods).returns %w(bar bat)
        FooClass.stubs(:_defined_instance_methods).returns []
        DingClass.stubs(:_defined_methods).returns %w(dit doot)
        DingClass.stubs(:_defined_instance_methods).returns []
        @mock_loader = mock
        @mock_loader.stubs(:classes).returns @classes
        @mock_loader.stubs(:modules).returns []
        @mock_loader.stubs(:top_level_methods).returns []
        @probe = Trapeze::Probe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_probeEXCLAMATION
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_class_probe_results
        expected = [{:class => FooClass,
                     :class_method_probings => [{:method_name => 'bar',
                                                 :args => [[]],
                                                 :returned => nil},
                                                {:method_name => 'bat',
                                                 :args => [[]],
                                                 :returned => nil}]},
                    {:class => DingClass,
                     :class_method_probings => [{:method_name => 'dit',
                                                 :args => [[]],
                                                 :returned => nil},
                                                {:method_name => 'doot',
                                                 :args => [[]],
                                                 :returned => nil}]}]
         assert_probe_results expected, @probe.class_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_top_level_method_probe_results
        assert_equal [], @probe.top_level_method_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_top_level_method_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.top_level_method_probe_results
        @probe.top_level_method_probe_results
      end
      
    end
    
    class ClassesWithOneArgMetaclassMethodsThatReturnTheReturnValueOfAMethodOnArg < Test::Unit::TestCase
      
      class FooClass
        
        class << self
          
          def bar(baz)
            baz.to_s
          end
          
          def bat(pwop)
            pwop.to_s
          end
          
        end
        
      end
      
      class DingClass
        
        class << self
          
          def doot(deet)
            deet.to_s
          end
          
          def dit(dot)
            dot.to_s
          end
          
        end
        
      end
      
      def setup
        @classes = [FooClass, DingClass]
        FooClass.stubs(:_defined_methods).returns %w(bar bat)
        FooClass.stubs(:_defined_instance_methods).returns []
        DingClass.stubs(:_defined_methods).returns %w(dit doot)
        DingClass.stubs(:_defined_instance_methods).returns []
        @mock_loader = mock
        @mock_loader.stubs(:classes).returns @classes
        @mock_loader.stubs(:modules).returns []
        @mock_loader.stubs(:top_level_methods).returns []
        @probe = Trapeze::Probe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_probeEXCLAMATION
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_class_probe_results
        expected = [{:class => FooClass,
                     :class_method_probings => [{:method_name => 'bar',
                                                 :args => [[:method_name => 'to_s',
                                                            :returned => Trapeze::Envelope.new]],
                                                 :returned => Trapeze::Envelope.new},
                                                {:method_name => 'bat',
                                                 :args => [[:method_name => 'to_s',
                                                            :returned => Trapeze::Envelope.new]],
                                                 :returned => Trapeze::Envelope.new}]},
                    {:class => DingClass,
                     :class_method_probings => [{:method_name => 'dit',
                                                 :args => [[:method_name => 'to_s',
                                                            :returned => Trapeze::Envelope.new]],
                                                 :returned => Trapeze::Envelope.new},
                                                {:method_name => 'doot',
                                                 :args => [[:method_name => 'to_s',
                                                            :returned => Trapeze::Envelope.new]],
                                                 :returned => Trapeze::Envelope.new}]}]
        assert_probe_results expected, @probe.class_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_top_level_method_probe_results
        assert_equal [], @probe.top_level_method_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_top_level_method_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.top_level_method_probe_results
        @probe.top_level_method_probe_results
      end
      
    end
    
    class ClassesWithArglessClassMethodsThatDoNothing < Test::Unit::TestCase
      
      class FooClass
        
        def self.bar; end
        
        def self.baz; end
        
      end
      
      class BatClass
        
        def self.pwop; end
        
        def self.ding; end
        
      end
      
      def setup
        @classes = [FooClass, BatClass]
        FooClass.stubs(:_defined_methods).returns %w(bar baz)
        FooClass.stubs(:_defined_instance_methods).returns []
        BatClass.stubs(:_defined_methods).returns %w(ding pwop)
        BatClass.stubs(:_defined_instance_methods).returns []
        @mock_loader = mock
        @mock_loader.stubs(:classes).returns @classes
        @mock_loader.stubs(:modules).returns []
        @mock_loader.stubs(:top_level_methods).returns []
        @probe = Trapeze::Probe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_probeEXCLAMATION
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_class_probe_results
        expected = [{:class => FooClass,
                     :class_method_probings => [{:method_name => 'bar',
                                                 :returned => nil},
                                                {:method_name => 'baz',
                                                 :returned => nil}]},
                    {:class => BatClass,
                     :class_method_probings => [{:method_name => 'ding',
                                                 :returned => nil},
                                                {:method_name => 'pwop',
                                                 :returned => nil}]}]
        assert_probe_results expected, @probe.class_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_top_level_method_probe_results
        assert_equal [], @probe.top_level_method_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_top_level_method_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.top_level_method_probe_results
        @probe.top_level_method_probe_results
      end
      
    end
    
    class ClassesWithArglessInstanceMethodsThatDoNothing < Test::Unit::TestCase
      
      class FooClass
        
        def bar; end
        
        def baz; end
        
      end
      
      class BatClass
        
        def pwop; end
        
        def ding; end
        
      end
      
      def setup
        @classes = [FooClass, BatClass]
        FooClass.stubs(:_defined_methods).returns []
        FooClass.stubs(:_defined_instance_methods).returns %w(bar baz)
        BatClass.stubs(:_defined_methods).returns []
        BatClass.stubs(:_defined_instance_methods).returns %w(ding pwop)
        @mock_loader = mock
        @mock_loader.stubs(:classes).returns @classes
        @mock_loader.stubs(:modules).returns []
        @mock_loader.stubs(:top_level_methods).returns []
        @probe = Trapeze::Probe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_probeEXCLAMATION
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_class_probe_results
        expected = [{:class => FooClass,
                     :instantiation => {:method_name => 'new'},
                     :instance_method_probings => [{:method_name => 'bar',
                                                    :returned => nil},
                                                   {:method_name => 'baz',
                                                    :returned => nil}]},
                    {:class => BatClass,
                     :instantiation => {:method_name => 'new'},
                     :instance_method_probings => [{:method_name => 'ding',
                                                    :returned => nil},
                                                   {:method_name => 'pwop',
                                                    :returned => nil}]}]
        assert_probe_results expected, @probe.class_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_top_level_method_probe_results
        assert_equal [], @probe.top_level_method_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_top_level_method_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.top_level_method_probe_results
        @probe.top_level_method_probe_results
      end
      
    end
    
    class ClassesWithArglessMetaclassMethodsAndArglessClassMethodsAndArglessInstanceMethodsThatDoNothing < Test::Unit::TestCase
      
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
      
      def setup
        @classes = [FooClass, DingClass]
        FooClass.stubs(:_defined_methods).returns %w(bar baz fizz fuzz)
        FooClass.stubs(:_defined_instance_methods).returns %w(bat pwop)
        DingClass.stubs(:_defined_methods).returns %w(biz buzz deet doot)
        DingClass.stubs(:_defined_instance_methods).returns %w(dit dot)
        @mock_loader = mock
        @mock_loader.stubs(:classes).returns @classes
        @mock_loader.stubs(:modules).returns []
        @mock_loader.stubs(:top_level_methods).returns []
        @probe = Trapeze::Probe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_probeEXCLAMATION
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_class_probe_results
        expected = [{:class => FooClass,
                     :class_method_probings => [{:method_name => 'bar',
                                                 :returned => nil},
                                                {:method_name => 'baz',
                                                 :returned => nil},
                                                {:method_name => 'fizz',
                                                 :returned => nil},
                                                {:method_name => 'fuzz',
                                                 :returned => nil}],
                     :instantiation => {:method_name => 'new'},
                     :instance_method_probings => [{:method_name => 'bat',
                                                    :returned => nil},
                                                   {:method_name => 'pwop',
                                                    :returned => nil}]},
                    {:class => DingClass,
                     :class_method_probings => [{:method_name => 'biz',
                                                 :returned => nil},
                                                {:method_name => 'buzz',
                                                 :returned => nil},
                                                {:method_name => 'deet',
                                                 :returned => nil},
                                                {:method_name => 'doot',
                                                 :returned => nil}],
                     :instantiation => {:method_name => 'new'},
                     :instance_method_probings => [{:method_name => 'dit',
                                                    :returned => nil},
                                                   {:method_name => 'dot',
                                                    :returned => nil}]}]
        assert_probe_results expected, @probe.class_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_top_level_method_probe_results
        assert_equal [], @probe.top_level_method_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_top_level_method_probe_results_twice
        @mock_loader.expects(:classes).returns @classes
        @mock_loader.expects(:modules).returns []
        @mock_loader.expects(:top_level_methods).returns []
        @probe.top_level_method_probe_results
        @probe.top_level_method_probe_results
      end
      
    end
    
  end
  
  module WithLoaderHavingModules
    
    class MethodlessModules < Test::Unit::TestCase
      
      module FooModule; end
      
      module BarModule; end
      
      def setup
        @modules = [FooModule, BarModule]
        FooModule.stubs(:_defined_methods).returns []
        FooModule.stubs(:_defined_instance_methods).returns []
        BarModule.stubs(:_defined_methods).returns []
        BarModule.stubs(:_defined_instance_methods).returns []
        @mock_loader = mock
        @mock_loader.stubs(:classes).returns []
        @mock_loader.stubs(:modules).returns @modules
        @mock_loader.stubs(:top_level_methods).returns []
        @probe = Trapeze::Probe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_probeEXCLAMATION
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_empty_array_when_sent_class_probe_results
        assert_equal [], @probe.class_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        expected = [{:module => FooModule}, {:module => BarModule}]
        assert_probe_results expected, @probe.module_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_top_level_method_probe_results
        assert_equal [], @probe.top_level_method_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_top_level_method_probe_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.top_level_method_probe_results
        @probe.top_level_method_probe_results
      end
      
    end
    
    class ModulesWithArglessMetaclassMethodsThatDoNothing < Test::Unit::TestCase
      
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
      
      def setup
        @modules = [FooModule, BatModule]
        FooModule.stubs(:_defined_methods).returns %w(bar baz)
        FooModule.stubs(:_defined_instance_methods).returns []
        BatModule.stubs(:_defined_methods).returns %w(ding pwop)
        BatModule.stubs(:_defined_instance_methods).returns []
        @mock_loader = mock
        @mock_loader.stubs(:classes).returns []
        @mock_loader.stubs(:modules).returns @modules
        @mock_loader.stubs(:top_level_methods).returns []
        @probe = Trapeze::Probe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_probeEXCLAMATION
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_empty_array_when_sent_class_probe_results
        assert_equal [], @probe.class_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_expected_results_when_sent_module_probe_results
        expected = [{:module => FooModule,
                     :module_method_probings => [{:method_name => 'bar',
                                                  :returned => nil},
                                                 {:method_name => 'baz',
                                                  :returned => nil}]},
                    {:module => BatModule,
                     :module_method_probings => [{:method_name => 'ding',
                                                  :returned => nil},
                                                 {:method_name => 'pwop',
                                                  :returned => nil}]}]
        assert_probe_results expected, @probe.module_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_top_level_method_probe_results
        assert_equal [], @probe.top_level_method_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_top_level_method_probe_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.top_level_method_probe_results
        @probe.top_level_method_probe_results
      end
      
    end
    
    class ModulesWithArglessClassMethodsThatDoNothing < Test::Unit::TestCase
      
      module FooModule
        
        def self.bar; end
        
        def self.baz; end
        
      end
      
      module BatModule
        
        def self.pwop; end
        
        def self.ding; end
        
      end
      
      def setup
        @modules = [FooModule, BatModule]
        FooModule.stubs(:_defined_methods).returns %w(bar baz)
        FooModule.stubs(:_defined_instance_methods).returns []
        BatModule.stubs(:_defined_methods).returns %w(ding pwop)
        BatModule.stubs(:_defined_instance_methods).returns []
        @mock_loader = mock
        @mock_loader.stubs(:classes).returns []
        @mock_loader.stubs(:modules).returns @modules
        @mock_loader.stubs(:top_level_methods).returns []
        @probe = Trapeze::Probe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_probeEXCLAMATION
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_empty_array_when_sent_class_probe_results
        assert_equal [], @probe.class_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_expected_results_when_sent_module_probe_results
        expected = [{:module => FooModule,
                     :module_method_probings => [{:method_name => 'bar',
                                                  :returned => nil},
                                                 {:method_name => 'baz',
                                                  :returned => nil}]},
                    {:module => BatModule,
                     :module_method_probings => [{:method_name => 'ding',
                                                  :returned => nil},
                                                 {:method_name => 'pwop',
                                                  :returned => nil}]}]
        assert_probe_results expected, @probe.module_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_module_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_top_level_method_probe_results
        assert_equal [], @probe.top_level_method_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_method_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.top_level_method_probe_results
        @probe.top_level_method_probe_results
      end
      
    end
    
    class ModulesWithArglessInstanceMethodsThatDoNothing < Test::Unit::TestCase
      
      module FooModule
        
        def bar; end
        
        def baz; end
        
      end
      
      module BatModule
        
        def pwop; end
        
        def ding; end
        
      end
      
      def setup
        @modules = [FooModule, BatModule]
        FooModule.stubs(:_defined_methods).returns []
        FooModule.stubs(:_defined_instance_methods).returns %w(bar baz)
        BatModule.stubs(:_defined_methods).returns []
        BatModule.stubs(:_defined_instance_methods).returns %w(ding pwop)
        @mock_loader = mock
        @mock_loader.stubs(:classes).returns []
        @mock_loader.stubs(:modules).returns @modules
        @mock_loader.stubs(:top_level_methods).returns []
        @probe = Trapeze::Probe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_probeEXCLAMATION
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_empty_array_when_sent_class_probe_results
        assert_equal [], @probe.class_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_expected_results_when_sent_module_probe_results
        expected = [{:module => FooModule,
                     :instance_method_probings => [{:method_name => 'bar',
                                                    :returned => nil},
                                                   {:method_name => 'baz',
                                                    :returned => nil}]},
                    {:module => BatModule,
                     :instance_method_probings => [{:method_name => 'ding',
                                                    :returned => nil},
                                                   {:method_name => 'pwop',
                                                    :returned => nil}]}]
        assert_probe_results expected, @probe.module_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_top_level_method_probe_results
        assert_equal [], @probe.top_level_method_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_top_level_method_probe_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.top_level_method_probe_results
        @probe.top_level_method_probe_results
      end
      
    end
    
    class ModulesWithArglessMetaclassMethodsAndArglessClassMethodsAndArglessInstanceMethodsThatDoNothing < Test::Unit::TestCase
      
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
      
      def setup
        @modules = [FooModule, DingModule]
        FooModule.stubs(:_defined_methods).returns %w(bar baz fizz fuzz)
        FooModule.stubs(:_defined_instance_methods).returns %w(bat pwop)
        DingModule.stubs(:_defined_methods).returns %w(biz buzz deet doot)
        DingModule.stubs(:_defined_instance_methods).returns %w(dit dot)
        @mock_loader = mock
        @mock_loader.stubs(:classes).returns []
        @mock_loader.stubs(:modules).returns @modules
        @mock_loader.stubs(:top_level_methods).returns []
        @probe = Trapeze::Probe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_probeEXCLAMATION
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_empty_array_when_sent_class_probe_results
        assert_equal [], @probe.class_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_expected_results_when_sent_module_probe_results
        expected = [{:module => FooModule,
                     :module_method_probings => [{:method_name => 'bar',
                                                  :returned => nil},
                                                 {:method_name => 'baz',
                                                  :returned => nil},
                                                 {:method_name => 'fizz',
                                                  :returned => nil},
                                                 {:method_name => 'fuzz',
                                                  :returned => nil}],
                     :instance_method_probings => [{:method_name => 'bat',
                                                    :returned => nil},
                                                   {:method_name => 'pwop',
                                                    :returned => nil}]},
                    {:module => DingModule,
                     :module_method_probings => [{:method_name => 'biz',
                                                  :returned => nil},
                                                 {:method_name => 'buzz',
                                                  :returned => nil},
                                                 {:method_name => 'deet',
                                                  :returned => nil},
                                                 {:method_name => 'doot',
                                                  :returned => nil}],
                     :instance_method_probings => [{:method_name => 'dit',
                                                    :returned => nil},
                                                   {:method_name => 'dot',
                                                    :returned => nil}]}]
        assert_probe_results expected, @probe.module_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_top_level_method_probe_results
        assert_equal [], @probe.top_level_method_probe_results
      end
      
      def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_top_level_method_probe_results_twice
        @mock_loader.expects(:classes).returns []
        @mock_loader.expects(:modules).returns @modules
        @mock_loader.expects(:top_level_methods).returns []
        @probe.top_level_method_probe_results
        @probe.top_level_method_probe_results
      end
      
    end
    
  end
  
  class WithLoaderHavingInstanceMethodsThatDoNothing < Test::Unit::TestCase
    
    module MethodsModule
      
      def bar; end
      
      def baz; end
      
    end
    
    def setup
      @bar = 'bar'
      @bar.stubs(:_to_method).returns stub_everything('Method', :arity => 0)
      @baz = 'baz'
      @baz.stubs(:_to_method).returns stub_everything('Method', :arity => 0)
      @top_level_methods = [@bar, @baz]
      @mock_loader = mock
      @mock_loader.stubs(:classes).returns []
      @mock_loader.stubs(:modules).returns []
      @mock_loader.stubs(:top_level_methods).returns @top_level_methods
      @probe = Trapeze::Probe.new(@mock_loader)
    end
    
    def test_should_return_expected_object_when_sent_loader
      assert_equal @mock_loader, @probe.loader
    end
    
    def test_should_return_self_when_sent_probeEXCLAMATION
      assert_equal @probe, @probe.probe!
    end
    
    def test_should_return_empty_array_when_sent_class_probe_results
      assert_equal [], @probe.class_probe_results
    end
    
    def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_class_probe_results_twice
      @mock_loader.expects(:classes).returns []
      @mock_loader.expects(:modules).returns []
      @mock_loader.expects(:top_level_methods).returns @top_level_methods
      @probe.class_probe_results
      @probe.class_probe_results
    end
    
    def test_should_return_empty_array_when_sent_module_probe_results
      assert_equal [], @probe.module_probe_results
    end
    
    def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_module_probe_results_twice
      @mock_loader.expects(:classes).returns []
      @mock_loader.expects(:modules).returns []
      @mock_loader.expects(:top_level_methods).returns @top_level_methods
      @probe.module_probe_results
      @probe.module_probe_results
    end
    
    def test_should_return_expected_results_when_sent_top_level_method_probe_results
      expected = [{:method_name => @bar, :returned => nil},
                  {:method_name => @baz, :returned => nil}]
      assert_envelope expected, @probe.top_level_method_probe_results
    end
    
    def test_should_call_loader_classes_and_modules_and_top_level_methods_once_each_when_sent_top_level_method_probe_results_twice
      @mock_loader.expects(:classes).returns []
      @mock_loader.expects(:modules).returns []
      @mock_loader.expects(:top_level_methods).returns @top_level_methods
      @probe.top_level_method_probe_results
      @probe.top_level_method_probe_results
    end
    
  end
  
end

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
      @mock_loader.stubs(:class_definitions).returns []
      @mock_loader.stubs(:module_definitions).returns []
      @mock_loader.stubs(:method_definitions).returns []
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
      @mock_loader.expects(:class_definitions).returns []
      @mock_loader.expects(:module_definitions).returns []
      @mock_loader.expects(:method_definitions).returns []
      @probe.class_probe_results
      @probe.class_probe_results
    end
    
    def test_should_return_empty_hash_when_sent_module_probe_results
      assert_equal [], @probe.module_probe_results
    end
    
    def test_should_call_loader_loadEXCLAMATION_once_when_sent_module_probe_results_twice
      @mock_loader.expects(:class_definitions).returns []
      @mock_loader.expects(:module_definitions).returns []
      @mock_loader.expects(:method_definitions).returns []
      @probe.module_probe_results
      @probe.module_probe_results
    end
    
    def test_should_return_empty_array_when_sent_method_probe_results
      assert_equal [], @probe.method_probe_results
    end
    
    def test_should_call_loader_loadEXCLAMATION_once_when_sent_method_probe_results_twice
      @mock_loader.expects(:class_definitions).returns []
      @mock_loader.expects(:module_definitions).returns []
      @mock_loader.expects(:method_definitions).returns []
      @probe.method_probe_results
      @probe.method_probe_results
    end
    
  end
  
  module WithLoaderHavingClasses
    
    class MethodlessClasses < Test::Unit::TestCase
      
      class FooClass; end
      
      class BarClass; end
      
      def setup
        @class_definitions = [FooClass, BarClass]
        @mock_loader = mock
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns []
        @mock_loader.stubs(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_method_probe_results
        assert_equal [], @probe.method_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_method_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.method_probe_results
        @probe.method_probe_results
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
        @class_definitions = [FooClass, BatClass]
        @mock_loader = mock
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns []
        @mock_loader.stubs(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_method_probe_results
        assert_equal [], @probe.method_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_method_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.method_probe_results
        @probe.method_probe_results
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
        @class_definitions = [FooClass, DingClass]
        @mock_loader = mock
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns []
        @mock_loader.stubs(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_method_probe_results
        assert_equal [], @probe.method_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_method_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.method_probe_results
        @probe.method_probe_results
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
        @class_definitions = [FooClass, DingClass]
        @mock_loader = mock
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns []
        @mock_loader.stubs(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_method_probe_results
        assert_equal [], @probe.method_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_method_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.method_probe_results
        @probe.method_probe_results
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
        @class_definitions = [FooClass, BatClass]
        @mock_loader = mock
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns []
        @mock_loader.stubs(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_method_probe_results
        assert_equal [], @probe.method_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_method_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.method_probe_results
        @probe.method_probe_results
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
        @class_definitions = [FooClass, BatClass]
        @mock_loader = mock
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns []
        @mock_loader.stubs(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_method_probe_results
        assert_equal [], @probe.method_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_method_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.method_probe_results
        @probe.method_probe_results
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
        @class_definitions = [FooClass, DingClass]
        @mock_loader = mock
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns []
        @mock_loader.stubs(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        assert_equal [], @probe.module_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_method_probe_results
        assert_equal [], @probe.method_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_method_probe_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns []
        @mock_loader.expects(:method_definitions).returns []
        @probe.method_probe_results
        @probe.method_probe_results
      end
      
    end
    
  end
  
  module WithLoaderHavingModules
    
    class MethodlessModules < Test::Unit::TestCase
      
      module FooModule; end
      
      module BarModule; end
      
      def setup
        @module_definitions = [FooModule, BarModule]
        @mock_loader = mock
        @mock_loader.stubs(:class_definitions).returns []
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
        @probe.class_probe_results
        @probe.class_probe_results
      end
      
      def test_should_return_empty_array_when_sent_module_probe_results
        expected = [{:module => FooModule}, {:module => BarModule}]
        assert_probe_results expected, @probe.module_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_method_probe_results
        assert_equal [], @probe.method_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_method_probe_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
        @probe.method_probe_results
        @probe.method_probe_results
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
        @module_definitions = [FooModule, BatModule]
        @mock_loader = mock
        @mock_loader.stubs(:class_definitions).returns []
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_method_probe_results
        assert_equal [], @probe.method_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_method_probe_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
        @probe.method_probe_results
        @probe.method_probe_results
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
        @module_definitions = [FooModule, BatModule]
        @mock_loader = mock
        @mock_loader.stubs(:class_definitions).returns []
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_module_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_method_probe_results
        assert_equal [], @probe.method_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_method_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
        @probe.method_probe_results
        @probe.method_probe_results
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
        @module_definitions = [FooModule, BatModule]
        @mock_loader = mock
        @mock_loader.stubs(:class_definitions).returns []
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_method_probe_results
        assert_equal [], @probe.method_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_method_probe_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
        @probe.method_probe_results
        @probe.method_probe_results
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
        @module_definitions = [FooModule, DingModule]
        @mock_loader = mock
        @mock_loader.stubs(:class_definitions).returns []
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_probe_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
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
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_module_probe_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
        @probe.module_probe_results
        @probe.module_probe_results
      end
      
      def test_should_return_empty_array_when_sent_method_probe_results
        assert_equal [], @probe.method_probe_results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_method_probe_results_twice
        @mock_loader.expects(:class_definitions).returns []
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns []
        @probe.method_probe_results
        @probe.method_probe_results
      end
      
    end
    
  end
  
  class WithLoaderHavingInstanceMethodsThatDoNothing < Test::Unit::TestCase
    
    module MethodsModule
      
      def bar; end
      
      def baz; end
      
    end
    
    def setup
      @method_definitions = ['bar'._to_instance_method(MethodsModule),
                             'baz'._to_instance_method(MethodsModule)]
      @mock_loader = mock
      @mock_loader.stubs(:class_definitions).returns []
      @mock_loader.stubs(:module_definitions).returns []
      @mock_loader.stubs(:method_definitions).returns @method_definitions
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
    
    def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_class_probe_results_twice
      @mock_loader.expects(:class_definitions).returns []
      @mock_loader.expects(:module_definitions).returns []
      @mock_loader.expects(:method_definitions).returns @method_definitions
      @probe.class_probe_results
      @probe.class_probe_results
    end
    
    def test_should_return_empty_array_when_sent_module_probe_results
      assert_equal [], @probe.module_probe_results
    end
    
    def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_module_probe_results_twice
      @mock_loader.expects(:class_definitions).returns []
      @mock_loader.expects(:module_definitions).returns []
      @mock_loader.expects(:method_definitions).returns @method_definitions
      @probe.module_probe_results
      @probe.module_probe_results
    end
    
    def test_should_return_expected_results_when_sent_method_probe_results
      expected = [{:method_name => 'bar', :returned => nil},
                  {:method_name => 'baz', :returned => nil}]
      assert_envelope expected, @probe.method_probe_results
    end
    
    def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_method_probe_results_twice
      @mock_loader.expects(:class_definitions).returns []
      @mock_loader.expects(:module_definitions).returns []
      @mock_loader.expects(:method_definitions).returns @method_definitions
      @probe.method_probe_results
      @probe.method_probe_results
    end
    
  end
  
end

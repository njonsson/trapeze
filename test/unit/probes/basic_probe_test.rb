require File.expand_path("#{File.dirname __FILE__}/../../test")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/probes/basic_probe")
require 'test/unit'
require 'rubygems'
require 'mocha'
require File.expand_path("#{File.dirname __FILE__}/../assertion_helpers_extension")

module Trapeze::Probes::BasicProbeTest
  
  class WithEmptyLoader < Test::Unit::TestCase
    
    def setup
      @mock_loader = mock
      @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
    end
    
    def test_should_return_expected_object_when_sent_loader
      assert_equal @mock_loader, @probe.loader
    end
    
    def test_should_return_self_when_sent_generateEXCLAMATION
      @mock_loader.stubs(:class_definitions).returns([])
      @mock_loader.stubs(:module_definitions).returns([])
      @mock_loader.stubs(:method_definitions).returns([])
      assert_equal @probe, @probe.probe!
    end
    
    def test_should_return_empty_array_when_sent_results
      @mock_loader.stubs(:class_definitions).returns([])
      @mock_loader.stubs(:module_definitions).returns([])
      @mock_loader.stubs(:method_definitions).returns([])
      assert_equal([], @probe.results)
    end
    
    def test_should_call_loader_loadEXCLAMATION_once_when_sent_results_twice
      @mock_loader.expects(:class_definitions).returns([])
      @mock_loader.expects(:module_definitions).returns([])
      @mock_loader.expects(:method_definitions).returns([])
      @probe.results
      @probe.results
    end
    
  end
  
  module WithLoaderHavingClasses
    
    class MethodlessClasses < Test::Unit::TestCase
      
      class FooClass; end
      
      class BarClass; end
      
      def setup
        @class_definitions = [FooClass, BarClass]
        @mock_loader = mock
        @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_empty_array_when_sent_results
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal([], @probe.results)
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns([])
        @mock_loader.expects(:method_definitions).returns([])
        @probe.results
        @probe.results
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
        @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_results
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        expected = [{:class => FooClass,
                     :class_method => 'bar',
                     :args => [],
                     :returned => nil},
                    {:class => FooClass,
                     :class_method => 'baz',
                     :args => [],
                     :returned => nil},
                    {:class => BatClass,
                     :class_method => 'pwop',
                     :args => [],
                     :returned => nil},
                    {:class => BatClass,
                     :class_method => 'ding',
                     :args => [],
                     :returned => nil}]
        assert_probe expected, @probe.results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns([])
        @mock_loader.expects(:method_definitions).returns([])
        @probe.results
        @probe.results
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
        @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_results
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        expected = [{:class => FooClass,
                     :class_method => 'bar',
                     :args => [Trapeze::Envelope.new],
                     :returned => nil},
                    {:class => FooClass,
                     :class_method => 'bat',
                     :args => [Trapeze::Envelope.new],
                     :returned => nil},
                    {:class => DingClass,
                     :class_method => 'doot',
                     :args => [Trapeze::Envelope.new],
                     :returned => nil},
                    {:class => DingClass,
                     :class_method => 'dit',
                     :args => [Trapeze::Envelope.new],
                     :returned => nil}]
        assert_probe expected, @probe.results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns([])
        @mock_loader.expects(:method_definitions).returns([])
        @probe.results
        @probe.results
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
        @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_results
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        expected = [{:class => FooClass,
                     :class_method => 'bar',
                     :args => [Trapeze::Envelope.new(Trapeze::Message.new(:method_name => 'to_s',
                                                                          :returned => Trapeze::Envelope.new))],
                     :returned => Trapeze::Envelope.new},
                    {:class => FooClass,
                     :class_method => 'bat',
                     :args => [Trapeze::Envelope.new(Trapeze::Message.new(:method_name => 'to_s',
                                                                          :returned => Trapeze::Envelope.new))],
                     :returned => Trapeze::Envelope.new},
                    {:class => DingClass,
                     :class_method => 'doot',
                     :args => [Trapeze::Envelope.new(Trapeze::Message.new(:method_name => 'to_s',
                                                                          :returned => Trapeze::Envelope.new))],
                     :returned => Trapeze::Envelope.new},
                    {:class => DingClass,
                     :class_method => 'dit',
                     :args => [Trapeze::Envelope.new(Trapeze::Message.new(:method_name => 'to_s',
                                                                          :returned => Trapeze::Envelope.new))],
                     :returned => Trapeze::Envelope.new}]
        results = @probe.results
        assert_probe expected, results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns([])
        @mock_loader.expects(:method_definitions).returns([])
        @probe.results
        @probe.results
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
        @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_results
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        expected = [{:class => FooClass,
                     :class_method => 'bar',
                     :args => [],
                     :returned => nil},
                    {:class => FooClass,
                     :class_method => 'baz',
                     :args => [],
                     :returned => nil},
                    {:class => BatClass,
                     :class_method => 'pwop',
                     :args => [],
                     :returned => nil},
                    {:class => BatClass,
                     :class_method => 'ding',
                     :args => [],
                     :returned => nil}]
        assert_probe expected, @probe.results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns([])
        @mock_loader.expects(:method_definitions).returns([])
        @probe.results
        @probe.results
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
        @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_results
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        expected = [{:class => FooClass,
                     :instance_method => 'bar',
                     :args => [],
                     :returned => nil},
                    {:class => FooClass,
                     :instance_method => 'baz',
                     :args => [],
                     :returned => nil},
                    {:class => BatClass,
                     :instance_method => 'pwop',
                     :args => [],
                     :returned => nil},
                    {:class => BatClass,
                     :instance_method => 'ding',
                     :args => [],
                     :returned => nil}]
        assert_probe expected, @probe.results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns([])
        @mock_loader.expects(:method_definitions).returns([])
        @probe.results
        @probe.results
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
        @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_results
        @mock_loader.stubs(:class_definitions).returns @class_definitions
        @mock_loader.stubs(:module_definitions).returns([])
        @mock_loader.stubs(:method_definitions).returns([])
        expected = [{:class => FooClass,
                     :class_method => 'fizz',
                     :args => [],
                     :returned => nil},
                    {:class => FooClass,
                     :class_method => 'fuzz',
                     :args => [],
                     :returned => nil},
                    {:class => FooClass,
                     :class_method => 'bar',
                     :args => [],
                     :returned => nil},
                    {:class => FooClass,
                     :class_method => 'baz',
                     :args => [],
                     :returned => nil},
                    {:class => FooClass,
                     :instance_method => 'bat',
                     :args => [],
                     :returned => nil},
                    {:class => FooClass,
                     :instance_method => 'pwop',
                     :args => [],
                     :returned => nil},
                    {:class => DingClass,
                     :class_method => 'biz',
                     :args => [],
                     :returned => nil},
                    {:class => DingClass,
                     :class_method => 'buzz',
                     :args => [],
                     :returned => nil},
                    {:class => DingClass,
                     :class_method => 'doot',
                     :args => [],
                     :returned => nil},
                    {:class => DingClass,
                     :class_method => 'deet',
                     :args => [],
                     :returned => nil},
                    {:class => DingClass,
                     :instance_method => 'dit',
                     :args => [],
                     :returned => nil},
                    {:class => DingClass,
                     :instance_method => 'dot',
                     :args => [],
                     :returned => nil}]
        assert_probe expected, @probe.results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_results_twice
        @mock_loader.expects(:class_definitions).returns @class_definitions
        @mock_loader.expects(:module_definitions).returns([])
        @mock_loader.expects(:method_definitions).returns([])
        @probe.results
        @probe.results
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
        @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        @mock_loader.stubs(:class_definitions).returns([])
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_empty_array_when_sent_results
        @mock_loader.stubs(:class_definitions).returns([])
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal([], @probe.results)
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_results_twice
        @mock_loader.expects(:class_definitions).returns([])
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns([])
        @probe.results
        @probe.results
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
        @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        @mock_loader.stubs(:class_definitions).returns([])
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_results
        @mock_loader.stubs(:class_definitions).returns([])
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns([])
        expected = [{:module => FooModule,
                     :class_method => 'bar',
                     :args => [],
                     :returned => nil},
                    {:module => FooModule,
                     :class_method => 'baz',
                     :args => [],
                     :returned => nil},
                    {:module => BatModule,
                     :class_method => 'pwop',
                     :args => [],
                     :returned => nil},
                    {:module => BatModule,
                     :class_method => 'ding',
                     :args => [],
                     :returned => nil}]
        assert_probe expected, @probe.results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_results_twice
        @mock_loader.expects(:class_definitions).returns([])
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns([])
        @probe.results
        @probe.results
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
        @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        @mock_loader.stubs(:class_definitions).returns([])
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_results
        @mock_loader.stubs(:class_definitions).returns([])
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns([])
        expected = [{:module => FooModule,
                     :class_method => 'bar',
                     :args => [],
                     :returned => nil},
                    {:module => FooModule,
                     :class_method => 'baz',
                     :args => [],
                     :returned => nil},
                    {:module => BatModule,
                     :class_method => 'pwop',
                     :args => [],
                     :returned => nil},
                    {:module => BatModule,
                     :class_method => 'ding',
                     :args => [],
                     :returned => nil}]
        assert_probe expected, @probe.results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_results_twice
        @mock_loader.expects(:class_definitions).returns([])
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns([])
        @probe.results
        @probe.results
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
        @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        @mock_loader.stubs(:class_definitions).returns([])
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_results
        @mock_loader.stubs(:class_definitions).returns([])
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns([])
        expected = [{:module => FooModule,
                     :instance_method => 'bar',
                     :args => [],
                     :returned => nil},
                    {:module => FooModule,
                     :instance_method => 'baz',
                     :args => [],
                     :returned => nil},
                    {:module => BatModule,
                     :instance_method => 'pwop',
                     :args => [],
                     :returned => nil},
                    {:module => BatModule,
                     :instance_method => 'ding',
                     :args => [],
                     :returned => nil}]
        assert_probe expected, @probe.results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_results_twice
        @mock_loader.expects(:class_definitions).returns([])
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns([])
        @probe.results
        @probe.results
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
        @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
      end
      
      def test_should_return_expected_object_when_sent_loader
        assert_equal @mock_loader, @probe.loader
      end
      
      def test_should_return_self_when_sent_generateEXCLAMATION
        @mock_loader.stubs(:class_definitions).returns([])
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns([])
        assert_equal @probe, @probe.probe!
      end
      
      def test_should_return_expected_results_when_sent_results
        @mock_loader.stubs(:class_definitions).returns([])
        @mock_loader.stubs(:module_definitions).returns @module_definitions
        @mock_loader.stubs(:method_definitions).returns([])
        expected = [{:module => FooModule,
                     :class_method => 'fizz',
                     :args => [],
                     :returned => nil},
                    {:module => FooModule,
                     :class_method => 'fuzz',
                     :args => [],
                     :returned => nil},
                    {:module => FooModule,
                     :class_method => 'bar',
                     :args => [],
                     :returned => nil},
                    {:module => FooModule,
                     :class_method => 'baz',
                     :args => [],
                     :returned => nil},
                    {:module => FooModule,
                     :instance_method => 'bat',
                     :args => [],
                     :returned => nil},
                    {:module => FooModule,
                     :instance_method => 'pwop',
                     :args => [],
                     :returned => nil},
                    {:module => DingModule,
                     :class_method => 'biz',
                     :args => [],
                     :returned => nil},
                    {:module => DingModule,
                     :class_method => 'buzz',
                     :args => [],
                     :returned => nil},
                    {:module => DingModule,
                     :class_method => 'doot',
                     :args => [],
                     :returned => nil},
                    {:module => DingModule,
                     :class_method => 'deet',
                     :args => [],
                     :returned => nil},
                    {:module => DingModule,
                     :instance_method => 'dit',
                     :args => [],
                     :returned => nil},
                    {:module => DingModule,
                     :instance_method => 'dot',
                     :args => [],
                     :returned => nil}]
        assert_probe expected, @probe.results
      end
      
      def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_results_twice
        @mock_loader.expects(:class_definitions).returns([])
        @mock_loader.expects(:module_definitions).returns @module_definitions
        @mock_loader.expects(:method_definitions).returns([])
        @probe.results
        @probe.results
      end
      
    end
    
  end
  
  class WithLoaderHavingInstanceMethodsThatDoNothing < Test::Unit::TestCase
    
    module MethodsModule
      
      def bar; end
      
      def baz; end
      
    end
    
    def setup
      @method_definitions = ['bar'.to_instance_method(MethodsModule),
                             'baz'.to_instance_method(MethodsModule)]
      @mock_loader = mock
      @probe = Trapeze::Probes::BasicProbe.new(@mock_loader)
    end
    
    def test_should_return_expected_object_when_sent_loader
      assert_equal @mock_loader, @probe.loader
    end
    
    def test_should_return_self_when_sent_generateEXCLAMATION
      @mock_loader.stubs(:class_definitions).returns([])
      @mock_loader.stubs(:module_definitions).returns([])
      @mock_loader.stubs(:method_definitions).returns @method_definitions
      assert_equal @probe, @probe.probe!
    end
    
    def test_should_return_expected_results_when_sent_results
      @mock_loader.stubs(:class_definitions).returns([])
      @mock_loader.stubs(:module_definitions).returns([])
      @mock_loader.stubs(:method_definitions).returns @method_definitions
      expected = [{:method => 'bar', :args => [], :returned => nil},
                  {:method => 'baz', :args => [], :returned => nil}]
      assert_probe expected, @probe.results
    end
    
    def test_should_call_loader_class_definitions_and_module_definitions_and_method_definitions_once_each_when_sent_results_twice
      @mock_loader.expects(:class_definitions).returns([])
      @mock_loader.expects(:module_definitions).returns([])
      @mock_loader.expects(:method_definitions).returns @method_definitions
      @probe.results
      @probe.results
    end
    
  end
  
end

require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/courier")
require File.expand_path("#{File.dirname __FILE__}/../../lib/envelope")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/assertion_helpers_extension")

module Trapeze::CourierTest
  
  class Untouched < Test::Unit::TestCase
    
    def test_should_return_empty_envelope_when_sent___seal_envelope__
      courier = Trapeze::Courier.new
      assert_equal Trapeze::Envelope.new, courier.__seal_envelope__
    end
    
  end
  
  module WithOneMethodCall
    
    class HavingNoArgs < Test::Unit::TestCase
      
      def setup
        @courier = Trapeze::Courier.new
        @courier.foo
      end
      
      def test_should_return_envelope_containing_expected_message_when_sent___seal_envelope__
        assert_envelope [{:method_name => 'foo',
                          :args => [],
                          :returned => Trapeze::Envelope.new}],
                        @courier.__seal_envelope__
      end
      
    end
    
    module HavingOneArg
      
      class ASymbol < Test::Unit::TestCase
        
        def setup
          @courier = Trapeze::Courier.new
          @courier.foo 'bar'
        end
        
        def test_should_return_array_containing_expected_message_when_sent___seal_envelope__
          assert_envelope [{:method_name => 'foo',
                            :args => ['bar'],
                            :returned => Trapeze::Envelope.new}],
                          @courier.__seal_envelope__
        end
        
      end
      
      class AnArray < Test::Unit::TestCase
        
        def setup
          @courier = Trapeze::Courier.new
          @courier.foo [:'1', '2', 3]
        end
        
        def test_should_return_array_containing_expected_message_when_sent___seal_envelope__
          assert_envelope [{:method_name => 'foo',
                            :args => [[:'1', '2', 3]],
                            :returned => Trapeze::Envelope.new}],
                          @courier.__seal_envelope__
        end
        
      end
      
      class AHashArg < Test::Unit::TestCase
        
        def setup
          @courier = Trapeze::Courier.new
          @courier.foo 'bar' => :baz
        end
        
        def test_should_return_array_containing_expected_message_when_sent___seal_envelope__
          assert_envelope [{:method_name => 'foo',
                            :args => [{'bar' => :baz}],
                            :returned => Trapeze::Envelope.new}],
                          @courier.__seal_envelope__
        end
        
      end
      
      class ABlock < Test::Unit::TestCase
        
        def setup
          @courier = Trapeze::Courier.new
          @time = Time.now
          @courier.foo { @time }
        end
        
        def test_should_return_array_containing_expected_message_when_sent___seal_envelope__
          assert_envelope [{:method_name => 'foo',
                            :args => [],
                            :block => lambda { @time },
                            :returned => Trapeze::Envelope.new}],
                          @courier.__seal_envelope__
        end
        
      end
      
    end
    
    module HavingTwoArgs
      
      class Symbols < Test::Unit::TestCase
        
        def setup
          @courier = Trapeze::Courier.new
          @courier.foo 'bar', :baz
        end
        
        def test_should_return_array_containing_expected_message_when_sent___seal_envelope__
          assert_envelope [{:method_name => 'foo',
                            :args => ['bar', :baz],
                            :returned => Trapeze::Envelope.new}],
                          @courier.__seal_envelope__
        end
        
      end
      
      class Arrays < Test::Unit::TestCase
        
        def setup
          @courier = Trapeze::Courier.new
          @courier.foo [:'1', '2', 3], [:'4', '5', 6]
        end
        
        def test_should_return_array_containing_expected_message_when_sent___seal_envelope__
          assert_envelope [{:method_name => 'foo',
                            :args => [[:'1', '2', 3], [:'4', '5', 6]],
                            :returned => Trapeze::Envelope.new}],
                          @courier.__seal_envelope__
        end
        
      end
      
      class ASymbolAndAHashArg < Test::Unit::TestCase
        
        def setup
          @courier = Trapeze::Courier.new
          @courier.foo 'bar', :baz => :bat
        end
        
        def test_should_return_array_containing_expected_message_when_sent___seal_envelope__
          assert_envelope [{:method_name => 'foo',
                            :args => ['bar', {:baz => :bat}],
                            :returned => Trapeze::Envelope.new}],
                          @courier.__seal_envelope__
        end
        
      end
      
      class ASymbolAndABlock < Test::Unit::TestCase
        
        def setup
          @courier = Trapeze::Courier.new
          @time = Time.now
          @courier.foo('bar') { @time }
        end
        
        def test_should_return_array_containing_expected_message_when_sent___seal_envelope__
          assert_envelope [{:method_name => 'foo',
                            :args => ['bar'],
                            :block => lambda { @time },
                            :returned => Trapeze::Envelope.new}],
                          @courier.__seal_envelope__
        end
        
      end
      
    end
    
    module HavingThreeArgs
      
      class Symbols < Test::Unit::TestCase
        
        def setup
          @courier = Trapeze::Courier.new
          @courier.foo 'bar', :baz, :bat
        end
        
        def test_should_return_array_containing_expected_message_when_sent___seal_envelope__
          assert_envelope [{:method_name => 'foo',
                            :args => ['bar', :baz, :bat],
                            :returned => Trapeze::Envelope.new}],
                          @courier.__seal_envelope__
        end
        
      end
      
      class Arrays < Test::Unit::TestCase
        
        def setup
          @courier = Trapeze::Courier.new
          @courier.foo [:'1', '2', 3], [:'4', '5', 6], [:'7', '8', 9]
        end
        
        def test_should_return_array_containing_expected_message_when_sent___seal_envelope__
          assert_envelope [{:method_name => 'foo',
                            :args => [[:'1', '2', 3],
                                      [:'4', '5', 6],
                                      [:'7', '8', 9]],
                            :returned => Trapeze::Envelope.new}],
                          @courier.__seal_envelope__
        end
        
      end
      
      class ASymbolAndAHashArgAndABlock < Test::Unit::TestCase
        
        def setup
          @courier = Trapeze::Courier.new
          @time = Time.now
          @courier.foo('bar', :baz => :bat) { @time }
        end
        
        def test_should_return_array_containing_expected_message_when_sent___seal_envelope__
          assert_envelope [{:method_name => 'foo',
                            :args => ['bar',
                                      {:baz => :bat}],
                            :block => lambda { @time },
                            :returned => Trapeze::Envelope.new}],
                          @courier.__seal_envelope__
        end
        
      end
      
    end
    
  end
  
  module WithTwoMethodCalls
    
    module ToTheSameMethod
      
      class HavingNoArgs < Test::Unit::TestCase
        
        def setup
          @courier = Trapeze::Courier.new
          @courier.foo
          @courier.foo
        end
        
        def test_should_return_array_containing_expected_messages_when_sent___seal_envelope__
          assert_envelope [{:method_name => 'foo',
                            :args => [],
                            :returned => Trapeze::Envelope.new},
                           {:method_name => 'foo',
                            :args => [],
                            :returned => Trapeze::Envelope.new}],
                          @courier.__seal_envelope__
        end
        
      end
      
    end
    
    module ToDifferentMethods
      
      class HavingNoArgs < Test::Unit::TestCase
        
        def setup
          @courier = Trapeze::Courier.new
          @courier.foo
          @courier.bar
        end
        
        def test_should_return_array_containing_expected_messages_when_sent___seal_envelope__
          assert_envelope [{:method_name => 'foo',
                            :args => [],
                            :returned => Trapeze::Envelope.new},
                           {:method_name => 'bar',
                            :args => [],
                            :returned => Trapeze::Envelope.new}],
                          @courier.__seal_envelope__
        end
        
      end
      
    end
    
  end
  
  module WithOneMethodCallOnReturnValueOfMethodCall
    
    class HavingNoArgs < Test::Unit::TestCase
      
      def setup
        @courier = Trapeze::Courier.new
        @foo = @courier.foo
        @foo.bar
      end
      
      def test_should_return_array_containing_expected_message_when_sent___seal_envelope__
        inner_message = Trapeze::Message.new(:method_name => 'bar',
                                             :args => [],
                                             :returned => Trapeze::Envelope.new)
        assert_envelope [{:method_name => 'foo',
                          :args => [],
                          :returned => Trapeze::Envelope.new(inner_message)}],
                        @courier.__seal_envelope__
      end
      
    end
    
  end
  
end

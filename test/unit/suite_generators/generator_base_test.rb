require File.expand_path("#{File.dirname __FILE__}/../../test")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/suite_generators/generator_base")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/../../assertion_helpers_extension")

module Trapeze::SuiteGenerators::GeneratorBaseTest
  
  class Allocate < Test::Unit::TestCase
    
    def test_should_raise_runtime_error
      assert_raise_message(RuntimeError,
                           'Trapeze::SuiteGenerators::GeneratorBase is an ' +
                           'abstract class') do
        Trapeze::SuiteGenerators::GeneratorBase.allocate
      end
    end
    
  end
  
  class New < Test::Unit::TestCase
    
    def test_should_raise_runtime_error
      assert_raise_message(RuntimeError,
                           'Trapeze::SuiteGenerators::GeneratorBase is an ' +
                           'abstract class') do
        Trapeze::SuiteGenerators::GeneratorBase.new 'foo'
      end
    end
    
  end
  
end

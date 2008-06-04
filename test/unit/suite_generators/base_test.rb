require File.expand_path("#{File.dirname __FILE__}/../../test")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/trapeze/suite_generators/base")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/../../assertion_helpers_extension")

module Trapeze::SuiteGenerators::BaseTest
  
  class Allocate < Test::Unit::TestCase
    
    def test_should_raise_runtime_error
      assert_raise_message(RuntimeError,
                           'Trapeze::SuiteGenerators::Base is an abstract ' +
                           'class') do
        Trapeze::SuiteGenerators::Base.allocate
      end
    end
    
  end
  
  class New < Test::Unit::TestCase
    
    def test_should_raise_runtime_error
      assert_raise_message(RuntimeError,
                           'Trapeze::SuiteGenerators::Base is an abstract ' +
                           'class') do
        Trapeze::SuiteGenerators::Base.new 'foo'
      end
    end
    
  end
  
end

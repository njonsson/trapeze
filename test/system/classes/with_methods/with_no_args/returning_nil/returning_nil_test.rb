require File.expand_path("#{File.dirname __FILE__}/../../../../../test")
require File.expand_path("#{File.dirname __FILE__}/../../../../../../lib/executor")
require File.expand_path("#{File.dirname __FILE__}/../../../../../../lib/truncate_extension")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/../../../../../assertion_helpers_extension")

module Trapeze::SystemTest
  
  module Classes
    
    module Methods
      
      module WithNoArgs
        
        class ReturningNil < Test::Unit::TestCase
          
          def test_should_generate_expected_output
            input_path        = File.expand_path("#{File.dirname __FILE__}/input/**/*.rb")
            output_path       = File.expand_path("#{File.dirname __FILE__}/output")
            output_truth_path = File.expand_path("#{File.dirname __FILE__}/output_truth")
            Dir.truncate output_path if File.directory?(output_path)
            executor = Trapeze::Executor.new(input_path, output_path)
            executor.execute!
            assert_dirs_identical output_truth_path, output_path
          end
          
        end
        
      end
      
    end
    
  end
  
end
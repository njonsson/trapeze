require File.expand_path("#{File.dirname __FILE__}/../../../../../test")
require File.expand_path("#{File.dirname __FILE__}/../../../../../../lib/trapeze/application")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/../../../../../assertion_helpers_extension")
require 'fileutils'

module Trapeze::SystemTest
  
  module Modules
    
    module WithInstanceMethods
      
      module TakingNoArgs
        
        class ReturningNil < Test::Unit::TestCase
          
          def test_should_generate_expected_output
            input_path        = File.expand_path("#{File.dirname __FILE__}/input/**/*.rb")
            output_path       = File.expand_path("#{File.dirname __FILE__}/output")
            output_truth_path = File.expand_path("#{File.dirname __FILE__}/output_truth")
            FileUtils.rm_rf output_path if File.exist?(output_path)
            FileUtils.mkdir_p output_path
            Trapeze::Application.run input_path, output_path
            assert_dirs_identical output_truth_path, output_path
          end
          
        end
        
      end
      
    end
    
  end
  
end

require File.expand_path("#{File.dirname __FILE__}/../../../../../test")
require File.expand_path("#{File.dirname __FILE__}/../../../../../../lib/trapeze/application")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/../../../../../assertion_helpers_extension")
require 'fileutils'

module Trapeze::SystemTest
  
  module Classes
    
    module WithInstanceMethods
      
      module TakingNoArgs
        
        class ReturningNil < Test::Unit::TestCase
          
          def test_should_generate_expected_output
            input_files_pattern = File.expand_path("#{File.dirname __FILE__}/input/**/*.rb")
            output_dir          = File.expand_path("#{File.dirname __FILE__}/output")
            output_truth_dir    = File.expand_path("#{File.dirname __FILE__}/output_truth")
            FileUtils.rm_rf(output_dir) if File.exist?(output_dir)
            FileUtils.mkdir_p output_dir
            Trapeze::Application.run input_files_pattern, output_dir
            assert_dirs_identical output_truth_dir, output_dir
          end
          
        end
        
      end
      
    end
    
  end
  
end

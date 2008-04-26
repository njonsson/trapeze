require File.expand_path("#{File.dirname __FILE__}/../../../../../test")
require File.expand_path("#{File.dirname __FILE__}/../../../../../../lib/trapeze/application")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/../../../../../assertion_helpers_extension")
require 'fileutils'

module Trapeze::SystemTest
  
  module Modules
    
    module WithInstanceMethods
      
      module TakingNoArgs
        
        class ReturningASymbol < Test::Unit::TestCase
          
          def test_should_generate_expected_output
            input_files_pattern = File.expand_path("#{File.dirname __FILE__}/input/**/*.rb")
            output_dir          = File.expand_path("#{File.dirname __FILE__}/output")
            output_truth_dir    = File.expand_path("#{File.dirname __FILE__}/output_truth")
            FileUtils.rm_rf(output_dir) if File.exist?(output_dir)
            FileUtils.mkdir_p output_dir
            application = Trapeze::Application.new('--input-files-pattern',
                                                   input_files_pattern,
                                                   '--output-dir',
                                                   output_dir)
            application.run!
            assert_dirs_identical output_truth_dir, output_dir
          end
          
        end
        
      end
      
    end
    
  end
  
end

require File.expand_path("#{File.dirname __FILE__}/../../../test")
require File.expand_path("#{File.dirname __FILE__}/../../../../lib/executor")
require 'test/unit'
require File.expand_path("#{File.dirname __FILE__}/../../../assertion_helpers_extension")
require 'fileutils'

module Trapeze::SystemTest
  
  module Modules
    
    class WithNoMethods < Test::Unit::TestCase
      
      def test_should_generate_expected_output
        input_path        = File.expand_path("#{File.dirname __FILE__}/input/**/*.rb")
        output_path       = File.expand_path("#{File.dirname __FILE__}/output")
        output_truth_path = File.expand_path("#{File.dirname __FILE__}/output_truth")
        FileUtils.rm_rf output_path if File.directory?(output_path)
        executor = Trapeze::Executor.new(input_path, output_path)
        executor.execute!
        assert_dirs_identical output_truth_path, output_path
      end
      
    end
    
  end
  
end

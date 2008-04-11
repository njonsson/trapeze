# Defines Trapeze::Executor.

require File.expand_path("#{File.dirname __FILE__}/loader")
require File.expand_path("#{File.dirname __FILE__}/probe")
require File.expand_path("#{File.dirname __FILE__}/suite_generators/test_unit")

# Runs the Trapeze program.
class Trapeze::Executor
  
  # The command-line arguments controlling the execution of Trapeze.
  attr_reader :args
  
  # Instantiates a new Trapeze::Executor with the arguments supplied in _args_.
  # Raises ArgumentError unless there are exactly two arguments or none at all.
  # The arguments are as follows:
  # 
  # 1. A file pattern containing source code to analyze. Defaults to
  #    'lib/**/*.rb'.
  # 2. A path to a directory where a suite will be generated. Defaults to
  #    'test/trapeze'.
  def initialize(*args)
    unless args.empty? || (args.length == 2)
      raise ArgumentError, 'expected two arguments'
    end
    @args = args
  end
  
  # Performs source code analysis and suite generation in accordance with
  # _args_.
  def execute!
    input_filenames = Dir.glob(args[0] || 'lib/**/*.rb')
    loader = Trapeze::Loader.new(*input_filenames)
    probe = Trapeze::Probe.new(loader)
    output_directory = args[1] || 'test/trapeze'
    generator = Trapeze::SuiteGenerators::TestUnit.new(:path => output_directory,
                                                       :probe => probe)
    generator.generate!
  end
  
end

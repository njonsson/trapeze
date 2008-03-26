# Defines Trapeze::Executor.

require File.expand_path("#{File.dirname __FILE__}/loader")
require File.expand_path("#{File.dirname __FILE__}/probes/basic_probe")
require File.expand_path("#{File.dirname __FILE__}/suite_generators/test_unit")

# Runs the Trapeze program.
class Trapeze::Executor
  
  attr_reader :args
  
  def initialize(*args)
    unless args.empty? || (args.length == 2)
      raise ArgumentError, 'expected two arguments'
    end
    @args = args
  end
  
  def execute!
    input_filenames = Dir.glob(args[0] || 'lib/**/*.rb')
    loader = Trapeze::Loader.new(*input_filenames)
    probe = Trapeze::Probes::BasicProbe.new(loader)
    output_directory = args[1] || 'test/trapeze'
    generator = Trapeze::SuiteGenerators::TestUnit.new(output_directory)
    generator.generate! probe.results
  end
  
end

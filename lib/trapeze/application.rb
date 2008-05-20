# Defines Trapeze::Application.

require File.expand_path("#{File.dirname __FILE__}/command")
require File.expand_path("#{File.dirname __FILE__}/loader")
require File.expand_path("#{File.dirname __FILE__}/probe")
require File.expand_path("#{File.dirname __FILE__}/suite_generators/test_unit")

# Runs the Trapeze program.
class Trapeze::Application
  
  # Instantiates a new Trapeze::Application, establishing execution options
  # supplied in _args_. Valid options are as follows:
  # 
  #   --input-files-pattern PATTERN
  #   --output-dir          PATH
  #   --help
  # 
  # The concise forms of these options are as follows:
  # 
  #   -i PATTERN
  #   -o PATH
  #   -h
  def initialize(*args)
    valid_options = {'--input-files-pattern' => %w(-i lib/**/*.rb),
                     '--output-dir'          => %w(-o test/trapeze),
                     '--quiet'               => '-q',
                     '--help'                => '-h'}
    @args = Trapeze::Command.new(:args => args,
                                         :valid_options => valid_options)
    unless @args.valid?
      $stderr.puts
      @args.errors.each do |arg, error_message|
        $stderr.puts "#{arg} #{error_message}"
      end
      print_help
      Kernel.exit
    end
    if @args.options[:help]
      print_help
      Kernel.exit
    end
  end
  
  # The arguments passed to Trapeze::Application.new.
  def args
    @args.args
  end
  
  # A file pattern containing source code to analyze. Defaults to
  # <i>lib/**/*.rb</i> if not specified in args.
  def input_files_pattern
    @args.options[:input_files_pattern]
  end
  
  # A path to a directory where a suite will be generated. Defaults to
  # <i>test/trapeze</i> if not specified in args.
  def output_dir
    @args.options[:output_dir]
  end
  
  # Runs the Trapeze program using the application options in _options_.
  def run!
    options = @args.options
    input_files = Dir.glob(options[:input_files_pattern])
    loader = Trapeze::Loader.new(*input_files)
    unless options[:quiet]
      loader.exceptions.each do |filename, exception|
        $stderr.puts "#{Trapeze::Sandbox.strip_from_message exception.message} " +
                     "in #{filename}"
      end
    end
    probe = Trapeze::Probe.new(loader)
    generator = Trapeze::SuiteGenerators::TestUnit.new(:input_files_pattern => options[:input_files_pattern],
                                                       :output_dir => options[:output_dir],
                                                       :probe => probe)
    generator.generate!
  end
  
private
  
  def print_help
    $stdout.puts <<-end_puts

Usage:

  trp [options]

Options:

  --input-files-pattern, -i filespattern   Sets a pattern for finding source
                                           code files to load and analyze. The
                                           syntax of filespattern conforms to
                                           Ruby's Dir.glob method. The default
                                           value of this option is
                                           'lib/**/*.rb'.

           --output-dir, -o path           Sets a path to a directory where
                                           generated files will be created. The
                                           default value of this option is
                                           'test/trapeze'.

                --quiet, -q                Suppresses all stdout and stderr
                                           output.

                 --help, -h                Displays this help message.
    end_puts
  end
  
end

# Defines Trapeze::Command.

# Encapsulates command-line arguments passed to the Trapeze application for
# controlling its execution.
class Trapeze::Command
  
private
  
  def self.option?(arg)
    ! (arg =~ /^-/).nil?
  end
  
public
  
  # The command-line arguments.
  attr_reader :args
  
  # The command-line options that are valid, along with default values for those
  # options.
  # 
  # This attribute is a hash in the following form:
  # 
  #   {'--a-long-option-name'       => ['-a', default_value_of_a],
  #    '--another-long-option-name' => ['-b', default_value_of_b]}
  # 
  # The long form of each option name is the key to an array containing the
  # short form of the option name and its default value.
  # 
  # Default values are optional -- they do not need to be specified, for
  # example:
  # 
  #   {'--an-option-without-default' => '-o'}
  # 
  # The long form of the option name is the key to the short form of the option
  # name.
  attr_reader :valid_options
  
  # Instantiates a new Trapeze::Command object with the specified _attributes_.
  # See _args_, options, _valid_options_, and errors for details on these
  # attributes.
  def initialize(attributes={})
    @args          = Array(attributes[:args])
    @valid_options = attributes[:valid_options] || {}
  end
  
  # Returns a hash in which the keys are invalid _args_ and the values are error
  # messages, calling valid? if they have not been validated already. The hash
  # is empty when valid? is +true+.
  def errors
    validate_or_get_results :errors
  end
  
  # Returns a hash in which the keys are symbols corresponding to the long names
  # of _valid_options_ and the values are either values specified in _args_ or
  # defaults, calling valid? if they have not been validated already. The hash
  # is empty when _valid_options_ is empty.
  def options
    validate_or_get_results :options
  end
  
  # Validates _args_ against _valid_options_, returning +true+ if there are no
  # errors.
  def valid?
    errors, options = {}, {}
    @results = {:errors => errors, :options => options}
    
    remaining_args = args.dup
    valid_options.each do |long_name, details|
      short_name, default = *details
      key = long_name.gsub(/^--/, '').gsub('-', '_').to_sym
      index = remaining_args.index(long_name) ||
              remaining_args.index(short_name)
      if index
        remaining_args.delete_at index
        if self.class.option?(remaining_args[index])
          options[key] = true
        else
          options[key] = remaining_args.delete_at(index)
        end
      else
        options[key] = default
      end
    end
    remaining_args.each do |arg|
      arg_type = self.class.option?(arg) ? 'option' : 'argument'
      errors[arg] = "is not a valid #{arg_type}"
    end
    
    errors.empty?
  end
  
private
  
  def validate_or_get_results(result)
    valid? unless @results
    @results[result]
  end
  
end

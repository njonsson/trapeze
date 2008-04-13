# Defines Trapeze::NameExtension.

# Adds a _name_ method to Method objects that provides the bare name of the
# method without the class information contained in Method#to_s.
module Trapeze::NameExtension
  
  # Returns just the name of a Method without an associated class identifier.
  def name
    to_s.match(regexp_for_name).captures.first
  end
  
private
  
  def regexp_for_name
    unless @regexp_for_name
      special_method_characters = '!%&*+-./<=>?@[]^|~'
      pattern = []
      pattern << "[#{Regexp.escape '.#'}]"
      pattern << '([\w'
      pattern << Regexp.escape(special_method_characters)
      pattern << ']+)'
      pattern << '>$'
      @regexp_for_name = Regexp.new(pattern.join)
    end
    @regexp_for_name
  end
  
end

Method.class_eval { include Trapeze::NameExtension }

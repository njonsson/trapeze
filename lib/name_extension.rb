# Defines Trapeze::NameExtension.

# Adds a _name_ method to Method objects that provides the bare name of the
# method without the class information contained in Method#to_s.
module Trapeze::NameExtension
  
  def name
    special_method_characters = '!%&*+-./<=>?@[]^|~'
    pattern = []
    pattern << "[#{Regexp.escape '.#'}]"
    pattern << '([\w'
    pattern << Regexp.escape(special_method_characters)
    pattern << ']+)'
    pattern << '>$'
    regexp = Regexp.new(pattern.join)
    to_s.match(regexp).captures.first
  end
  
end

Method.class_eval { include Trapeze::NameExtension }

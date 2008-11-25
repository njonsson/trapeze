# Defines Trapeze::NameExtension.

# Adds a _name method to Method objects that provides the bare name of the
# method without the class information contained in Method#to_s.
# 
# The name of this method is prefixed with an underscore character in order to
# reduce the likelihood of method name collisions, given that the purpose of
# Trapeze is to load and analyze other Ruby programs.
module Trapeze::NameExtension
  
  # Returns just the name of a Method without an associated class identifier.
  def _name
    to_s.match(_regexp_for_name).captures.first
  end
  
private
  
  def _regexp_for_name
    unless @_regexp_for_name
      special_method_characters = '!%&*+-./<=>?@[]^|~'
      pattern = []
      pattern << "[#{Regexp.escape '.#'}]"
      pattern << '([\w'
      pattern << Regexp.escape(special_method_characters)
      pattern << ']+)'
      pattern << '>$'
      @_regexp_for_name = Regexp.new(pattern.join)
    end
    @_regexp_for_name
  end
  
end

Method.class_eval { include Trapeze::NameExtension }

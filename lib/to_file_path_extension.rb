# Defines Trapeze::ToFilePathExtension.

# Adds a _to_file_path_ method to Class objects that converts the
# fully-qualified class name to a file path where the class could be expected to
# be defined.
module Trapeze::ToFilePathExtension
  
  # Returns the path to a file where the class could be expected to be defined.
  def to_file_path
    path = to_s.gsub('::',                  '/').
                gsub(/([a-z0-9])([A-Z])/,   '\1_\2').
                gsub(/([A-Z])([A-Z][a-z])/, '\1_\2')
    "#{path.downcase}.rb"
  end
  
end

Class.class_eval { include Trapeze::ToFilePathExtension }

# Defines Trapeze::StringComparisonExtension.

# Adds an implementation of the comparison operator, <tt><=></tt>, to Symbol.
# The operator compares two symbols alphanumerically.
module Trapeze::StringComparisonExtension
  
  # Returns an integer (-1, 0, or +1) if this object is less than, equal to, or
  # greater than _symbol_.
  def <=>(symbol)
    return nil unless self.class == symbol.class
    self.to_s <=> symbol.to_s
  end
  
end

Symbol.class_eval { include Trapeze::StringComparisonExtension }

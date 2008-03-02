# Defines Trapeze::StringComparisonExtension.

# Adds an implementation of the comparison operator, <=>, to Symbol. The
# operator compares two Symbol#to_s values.
module Trapeze::StringComparisonExtension
  
  # Returns an integer (-1, 0, or +1) if this object is less than, equal to,
  # or greater than _other_.
  def <=>(other)
    return nil unless self.class == other.class
    self.to_s <=> other.to_s
  end
  
end

Symbol.class_eval { include Trapeze::StringComparisonExtension }

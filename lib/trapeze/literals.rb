# Defines Trapeze::Literals.

require File.expand_path("#{File.dirname __FILE__}/string_matcher")

# Converts objects into their Ruby-literal representations.
class Trapeze::Literals
  
  # Returns a singleton instance of Trapeze::Literals with literal
  # representations for known classes.
  def self.built_in
    unless @instance
      @instance = self.new
      
      inspect_literal = lambda { |o| o.inspect }
      type_literal    = lambda { |o| o.name }
      
      @instance['Array'     ] = inspect_literal
      @instance['BigDecimal'] = lambda { |o| %Q<BigDecimal.new("#{o}")> }
      @instance['Bignum'    ] = inspect_literal
      @instance['Class'     ] = type_literal
      @instance['Complex'   ] = inspect_literal
      @instance['Date'      ] = lambda { |o| %Q<Date.parse("#{o}")> }
      @instance['DateTime'  ] = lambda { |o| %Q<DateTime.parse("#{o}")> }
      @instance['FalseClass'] = inspect_literal
      @instance['Fixnum'    ] = inspect_literal
      @instance['Float'     ] = inspect_literal
      @instance['Hash'      ] = inspect_literal
      @instance['Module'    ] = type_literal
      @instance['Range'     ] = inspect_literal
      @instance['Rational'  ] = inspect_literal
      @instance['Regexp'    ] = inspect_literal
      @instance['String'    ] = lambda do |o|
                                  string_matcher = Trapeze::StringMatcher.new(o)
                                  if string_matcher.pattern_required?
                                    string_matcher.pattern
                                  else
                                    o.inspect
                                  end
                                end
      @instance['Symbol'    ] = inspect_literal
      @instance['Time'      ] = lambda do |o|
                                  utc = o.utc
                                  expr = %w(year month day
                                            hour min sec usec).collect do |attr|
                                    utc.send(attr).to_s
                                  end.join(', ')
                                  "Time.utc(#{expr})"
                                end
      @instance['TrueClass' ] = inspect_literal
    end
    @instance
  end
  
  # Instantiates a new, empty Trapeze::Literals object.
  def initialize
    @registered = {}
  end
  
  # Returns the literal representation of _obj_ or +nil+ if no literal
  # representation is registered for the class of _obj_.
  def [](obj)
    return nil unless (literal = @registered[obj.class.to_s])
    literal.call obj
  end
  
  # Registers a literal representation of an object whose class is named
  # _class_name_. The _literal_ argument should be either +nil+ or a Proc or
  # block with an arity of 1.
  def []=(class_name, literal)
    @registered[class_name] = literal
    self
  end
  
end

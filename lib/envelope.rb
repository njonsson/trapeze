# Defines Trapeze::Envelope.

require File.expand_path("#{File.dirname __FILE__}/message")

# A collection of Trapeze::Message objects. This class exists because it is
# necessary to distinguish an array of Trapeze::Message objects (particularly an
# empty array) from an empty Array.
class Trapeze::Envelope
  
  include Enumerable
  
  # Instantiates a new Trapeze::Envelope containing the Trapeze::Message objects
  # supplied in _messages_.
  def initialize(*messages)
    messages.each { |m| raise_argument_error_unless_kind_of_message m }
    @messages = messages
  end
  
  # Returns the Trapeze::Message element at _index_.
  def [](index)
    @messages[index]
  end
  
#  def []=(index, message)
#    raise_argument_error_unless_kind_of_message message
#    @messages[index] = message
#    self
#  end
  
  # Pushes _message_ into the envelope.
  def <<(message)
    raise_argument_error_unless_kind_of_message message
    @messages << message
  end
  
  # Returns +true+ if _envelope_ contains the same number of elements and if
  # each element is equal to the corresponding element in _envelope_.
  def ==(envelope)
    return false unless (envelope.class == self.class)
    return false unless (@messages ==
                         envelope.instance_variable_get('@messages'))
    true
  end
  
  # Calls _block_ once for each element, passing that element as a parameter.
  def each(&block)
    @messages.each(&block)
  end
  
  # Returns +true+ if no elements. 
  def empty?
    @messages.empty?
  end
  
  # Returns the first element, or +nil+ if no elements.
  def first
    @messages.first
  end
  
  # Returns the last element, or +nil+ if no elements.
  def last
    @messages.last
  end
  
  # Returns the number of elements. May be zero.
  def length
    @messages.length
  end
  
  # Alias for length.
  def size
    @messages.size
  end
  
private
  
  def raise_argument_error_unless_kind_of_message(obj)
    unless obj.kind_of?(Trapeze::Message)
      raise ArgumentError, 'expected Trapeze::Message object'
    end
  end
  
end

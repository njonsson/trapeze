# Defines Trapeze::Envelope.

require File.expand_path("#{File.dirname __FILE__}/message")

# A collection of Trapeze::Message objects. This class exists because it is
# necessary to distinguish an empty array object from an array (of
# Trapeze::Message objects) that is empty.
class Trapeze::Envelope
  
  include Enumerable
  
  # Instantiates a new Trapeze::Envelope containing the elements supplied in
  # _messages_. Raises ArgumentError unless they are Trapeze::Message objects.
  def initialize(*messages)
    messages.each { |m| raise_unless_kind_of_message m }
    @messages = messages
  end
  
  # Returns the message element at _index_.
  def [](index)
    @messages[index]
  end
  
  # Pushes _message_ into the envelope. Raises ArgumentError unless it is a
  # Trapeze::Message.
  def <<(message)
    raise_unless_kind_of_message message
    @messages << message
  end
  
  # Returns +true+ if _envelope_ contains the same messages.
  def ==(envelope)
    return false unless (envelope.class == self.class)
    return false unless (@messages ==
                         envelope.instance_variable_get('@messages'))
    true
  end
  
  # Calls _block_ once for each message element, passing that element as a
  # parameter.
  def each(&block)
    @messages.each(&block)
  end
  
  # Returns +true+ if no message elements. 
  def empty?
    @messages.empty?
  end
  
  # Returns the first message element, or +nil+ if none.
  def first
    @messages.first
  end
  
  # Returns the last message element, or +nil+ if none.
  def last
    @messages.last
  end
  
  # Returns the number of message elements. May be zero.
  def length
    @messages.length
  end
  
  # Alias for length.
  def size
    @messages.size
  end
  
private
  
  def raise_unless_kind_of_message(obj)
    unless obj.kind_of?(Trapeze::Message)
      raise ArgumentError, 'expected Trapeze::Message object'
    end
  end
  
end

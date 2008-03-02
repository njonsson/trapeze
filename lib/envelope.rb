# Defines Trapeze::Envelope.

require File.expand_path("#{File.dirname __FILE__}/message")
require 'forwardable'

# A collection of Trapeze::Message objects. This class exists because it is
# necessary to distinguish an array of Trapeze::Message objects (particularly an
# empty array) from an empty Array object.
class Trapeze::Envelope
  
  extend Forwardable
  include Enumerable
  
  def_delegators :@messages, :each, :empty?, :first, :last, :length, :size
  
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
    return @messages == envelope.instance_variable_get('@messages')
  end
  
private
  
  def raise_argument_error_unless_kind_of_message(obj)
    unless obj.kind_of?(Trapeze::Message)
      raise ArgumentError, 'expected Trapeze::Message object'
    end
  end
  
end

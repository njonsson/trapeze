# Defines Trapeze::Courier.

require File.expand_path("#{File.dirname __FILE__}/envelope")

# Captures any method call made on it and returns another Trapeze::Courier
# object. Information about method calls is recorded in Trapeze::Message
# objects. A Trapeze::Courier object can be used to describe the interface that
# the calling code expects to use.
class Trapeze::Courier
  
  # Instantiates a new Trapeze::Courier.
  def initialize
    @__envelope__ = Trapeze::Envelope.new
  end
  
  # Returns the results of all interactions with the object and with the return
  # values it supplied to code calling its methods.
  def __seal_envelope__
    @__envelope__.inject(Trapeze::Envelope.new) do |envelope, message|
      args = Array(message[:args]).collect do |arg|
        begin
          arg.__seal_envelope__
        rescue NoMethodError
          arg
        end
      end
      
      returned = message[:returned]
#      begin
        returned = returned.__seal_envelope__
#      rescue NoMethodError
#      end
      
      envelope << {:method_name => message[:method_name],
                   :args => args,
                   :block => message[:block],
                   :returned => returned}
      envelope
    end
  end
  
  instance_methods.each { |m| undef_method(m) unless (m =~ /^__/) }
  
  def method_missing(method, *args, &block) #:nodoc:
    returned = Trapeze::Courier.new
    @__envelope__ << {:method_name => method.to_s,
                      :args => args,
                      :block => block,
                      :returned => returned}
    returned
  end
  
end

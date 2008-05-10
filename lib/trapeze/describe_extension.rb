# Defines Trapeze::DescribeExtension.

require File.expand_path("#{File.dirname __FILE__}/sandbox")

# Adds a <i>_describe</i> method to all objects that provides a description of
# their identity and state.
# 
# The name of this method is prefixed with an underscore character in order to
# reduce the likelihood of method name collisions, given that the purpose of
# Trapeze is to load and analyze other Ruby programs.
module Trapeze::DescribeExtension
  
private
  
  class Transform #:nodoc:
    
    SPELLINGS = {0 => 'zero',
                 1 => 'one',
                 2 => 'two',
                 3 => 'three',
                 4 => 'four',
                 5 => 'five',
                 6 => 'six',
                 7 => 'seven',
                 8 => 'eight',
                 9 => 'nine'}
    
    class << self
      
      def phrase(nouns)
        if nouns.length > 2
          "#{nouns[0...-1].join ', '} and #{nouns[-1]}"
        else
          nouns.join ' and '
        end
      end
      
      def spell(number)
        return number.to_s unless (spelled = SPELLINGS[number])
        spelled
      end
      
      def with_indefinite_article(noun)
        "#{(noun =~ /^[aeiou8]/i) ? 'an' : 'a'} #{noun}"
      end
      
    end
    
  end
  
public
  
  # Returns a description of an object's identity and state.
  def _describe
    if instance_of?(Array)
      if length < 1
        'an empty array'
      elsif length < 4
        descriptions = collect { |o| o._describe }
        "an array containing #{Transform.phrase descriptions}"
      else
        "an array of #{Transform.spell length} objects"
      end
    elsif instance_of?(Hash)
      if length < 1
        'an empty hash'
      elsif length < 4
        descriptions = keys.sort_by { |k| k.to_s }.collect do |k|
          "#{self[k]._describe} with a key of #{k._describe}"
        end
        "a hash containing #{Transform.phrase descriptions}"
      else
        "a hash of #{Transform.spell length} values"
      end
    elsif (self == true) || (self == false)
      to_s
    elsif nil? || instance_of?(String) || instance_of?(Symbol)
      inspect
    elsif instance_of?(Class) || instance_of?(Module)
      Trapeze::Sandbox.strip_from_type_name self
    elsif (self.class.to_s =~ /^Date(Time)?$/) || kind_of?(Numeric)
      to_s
    elsif kind_of?(Time)
      utc.to_s
    elsif instance_of?(Range)
      "a range from #{Transform.spell self.begin} "       +
      "#{exclude_end? ? 'to and excluding' : 'through'} " +
      Transform.spell(self.end)
    else
      class_name = Trapeze::Sandbox.strip_from_type_name(self.class)
      "#{Transform.with_indefinite_article class_name} object"
    end
  end
  
end

Object.class_eval { include Trapeze::DescribeExtension }

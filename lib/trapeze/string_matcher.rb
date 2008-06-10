# Defines Trapeze::StringMatcher.

# Creates a Regexp for a given string that matches the string verbatim, except
# for embedded object literals, for which patterns are substituted.
# 
# An object literal takes the form <tt>#<Foo::Bar:0xfffffff></tt>. The
# hexadecimal expression in the middle of it is an address in memory and is
# therefore not predictable. The fact that the exact objec literal is
# unpredictable necessitates using a regular expression to match it.
class Trapeze::StringMatcher
  
  # The string to be matched.
  attr_reader :string
  
  # Instantiates a new Trapeze::StringMatcher with the string supplied in
  # _string_.
  def initialize(string)
    @string = string
  end
  
  def _describe
    "a string matching #{string.gsub object_literal_pattern, '[an object literal]'}"
  end
  
  # Returns a Regexp that will match string even if it contains object literals.
  def pattern
    return nil unless string
    segments = explode.collect do |s|
      if s =~ object_literal_pattern
        s.gsub! /0x[0-9a-f]+>/, '0x>'
        Regexp.escape(s).gsub '0x>', '0x[0-9a-f]+>'
      else
        Regexp.escape s
      end
    end
    Regexp.new "^#{segments.join}$"
  end
  
  # Returns +true+ if pattern is required to reliably match string because it
  # contains object literals.
  def pattern_required?
    return false unless string
    ! string.match(object_literal_pattern).nil?
  end
  
private
  
  def explode
    segments = []
    previous_index = index = 0
    while (index = string.index(object_literal_pattern, previous_index)) do
      match_data = string[index..-1].match(object_literal_pattern)
      segments << string[previous_index...index]
      segments << string[index...match_data.end(0) + index]
      previous_index = match_data.end(0) + index
    end
    segments << string[previous_index..-1]
  end
  
  def object_literal_pattern
    /\#<[\w:]+?:0x[0-9a-f]+>/
  end
  
end

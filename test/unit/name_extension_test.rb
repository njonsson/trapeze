require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/name_extension")
require 'test/unit'

class Trapeze::NameExtensionTest < Test::Unit::TestCase
  
private
  
  def self.armor(string)
    string = string.dup
    [%w(! EXCLAMATION),
     %w(% PERCENT),
     %w(& AMPERSAND),
     %w(* ASTERISK),
     %w(+ PLUS),
     %w(- HYPHEN),
     %w(. DOT),
     %w(/ SLASH),
     %w(< LESSTHAN),
     %w(= EQUAL),
     %w(> GREATERTHAN),
     %w(? QUESTION),
     %w(@ AT),
     %w([ LEFTBRACKET),
     %w(] RIGHTBRACKET),
     %w(^ CARET),
#     %w(_ UNDERSCORE),
     %w(| PIPE),
     %w(~ TILDE)].each do |char, char_name|
      string.gsub! char, char_name
    end
    string
  end
  
public
  
  [:foo, 'bar', 1, [], {}, true].inject([]) do |all_methods, obj|
    obj.methods.each do |m|
      unless all_methods.include?(m)
        all_methods << m
        armored = armor(m)
        define_method("test_#{armored}_method_returns_#{armored}_when_sent_name") do
          method = obj.method(m)
          assert_not_equal m,
                           method.to_s,
                           'Expected Method#to_s to return something more ' +
                           'complicated than the bare name of the method'
          assert_equal m, method.name
        end
      end
    end
    all_methods
  end
  
end

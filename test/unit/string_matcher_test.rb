require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/string_matcher")
require 'test/unit'

module Trapeze::StringMatcherTest
  
  class WithNilString < Test::Unit::TestCase
    
    def setup
      @string_matcher = Trapeze::StringMatcher.new(nil)
    end
    
    def test_should_return_nil_when_sent_pattern
      assert_nil @string_matcher.pattern
    end
    
    def test_pattern_requiredQUESTION_returns_false
      assert_equal false, @string_matcher.pattern_required?
    end
    
  end
  
  class WithEmptyString < Test::Unit::TestCase
    
    def setup
      @string_matcher = Trapeze::StringMatcher.new('')
    end
    
    def test_should_return_empty_regexp_when_sent_pattern
      assert_equal /^$/, @string_matcher.pattern
    end
    
    def test_pattern_should_match_string
      assert_match @string_matcher.pattern, @string_matcher.string
    end
    
    def test_pattern_requiredQUESTION_returns_false
      assert_equal false, @string_matcher.pattern_required?
    end
    
  end
  
  class WithTypicalString < Test::Unit::TestCase
    
    def setup
      @string_matcher = Trapeze::StringMatcher.new('(foo) [bar]')
    end
    
    def test_should_return_expected_regexp_when_sent_pattern
      assert_equal /^\(foo\)\ \[bar\]$/, @string_matcher.pattern
    end
    
    def test_pattern_should_match_string
      assert_match @string_matcher.pattern, @string_matcher.string
    end
    
    def test_pattern_requiredQUESTION_returns_false
      assert_equal false, @string_matcher.pattern_required?
    end
    
  end
  
  class WithStringContainingOneObjectLiteral < Test::Unit::TestCase
    
    def setup
      @string_matcher = Trapeze::StringMatcher.new("(foo) #{Object.new} [bar]")
    end
    
    def test_should_return_expected_regexp_when_sent_pattern
      assert_equal /^\(foo\)\ \#<Object:0x[0-9a-f]+>\ \[bar\]$/,
                   @string_matcher.pattern
    end
    
    def test_pattern_should_match_string
      assert_match @string_matcher.pattern, @string_matcher.string
    end
    
    def test_pattern_requiredQUESTION_returns_true
      assert_equal true, @string_matcher.pattern_required?
    end
    
  end
  
  class WithStringContainingTwoObjectLiterals < Test::Unit::TestCase
    
    def setup
      string = "(foo) #{Object.new} [bar] #{Object.new} /baz/"
      @string_matcher = Trapeze::StringMatcher.new(string)
    end
    
    def test_should_return_expected_regexp_when_sent_pattern
      pattern = Regexp.new('^\(foo\)\ \#<Object:0x[0-9a-f]+>\ \[bar\]\ ' +
                           '\#<Object:0x[0-9a-f]+>\ /baz/$')
      assert_equal pattern, @string_matcher.pattern
    end
    
    def test_pattern_should_match_string
      assert_match @string_matcher.pattern, @string_matcher.string
    end
    
    def test_pattern_requiredQUESTION_returns_true
      assert_equal true, @string_matcher.pattern_required?
    end
    
  end
  
end

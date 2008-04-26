require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/inflections_extension")
require 'test/unit'

module Trapeze::InflectionsExtensionTest
  
  class UNDERSCOREPathify < Test::Unit::TestCase
    
    def test_with_lowercase_word
      assert_equal 'foo', 'foo'._pathify
    end
    
    def test_with_uppercase_word
      assert_equal 'foo', 'FOO'._pathify
    end
    
    def test_with_underscore_delimited_words
      assert_equal 'foo_bar', 'foo_bar'._pathify
    end
    
    def test_with_underscore_delimited_single_character_words
      assert_equal 'this_is_a_test', 'this_is_a_test'._pathify
    end
    
    def test_with_double_underscore_delimited_words
      assert_equal 'foo_bar', 'foo__bar'._pathify
    end
    
    def test_with_slash_delimited_words
      assert_equal 'foo/bar', 'foo/bar'._pathify
    end
    
    def test_with_double_slash_delimited_words
      assert_equal 'foo//bar', 'foo//bar'._pathify
    end
    
    def test_with_camel_case
      assert_equal 'foo_bar', 'FooBar'._pathify
    end
    
    def test_with_colon_delimited_camel_case_terms
      assert_equal 'foo_bar/baz_bat', 'FooBar:BazBat'._pathify
    end
    
    def test_with_colon_delimited_words
      assert_equal 'foo/bar', 'foo:bar'._pathify
    end
    
    def test_with_double_colon_delimited_camel_case_terms
      assert_equal 'foo_bar/baz_bat', 'FooBar::BazBat'._pathify
    end
    
    def test_with_leading_acronym
      assert_equal 'fbi_or_the_feds', 'FBIOrTheFeds'._pathify
    end
    
    def test_with_embedded_acronym
      assert_equal 'the_fbi_or_the_feds', 'TheFBIOrTheFeds'._pathify
    end
    
    def test_with_trailing_acronym
      assert_equal 'the_feds_or_the_fbi', 'TheFedsOrTheFBI'._pathify
    end
    
    def test_with_numerals_preceding_lowercase
      assert_equal '123abc', '123abc'._pathify
    end
    
    def test_with_numerals_preceding_uppercase
      assert_equal '123_abc', '123ABC'._pathify
    end
    
    def test_with_numerals_within_lowercase
      assert_equal 'abc_123def', 'abc123def'._pathify
    end
    
    def test_with_numerals_within_uppercase
      assert_equal 'abc123_def', 'ABC123DEF'._pathify
    end
    
    def test_with_numerals_following_lowercase
      assert_equal 'abc_123', 'abc123'._pathify
    end
    
    def test_with_numerals_following_uppercase
      assert_equal 'abc123', 'ABC123'._pathify
    end
    
    def test_with_multiple_punctuation_preceding_lowercase
      assert_equal '_foo', %q{"'foo}._pathify
    end
    
    def test_with_multiple_punctuation_preceding_uppercase
      assert_equal '_foo', %q{"'FOO}._pathify
    end
    
    def test_with_multiple_punctuation_within_lowercase
      assert_equal 'foo_bar', 'foo--bar'._pathify
    end
    
    def test_with_multiple_punctuation_within_uppercase
      assert_equal 'foo_bar', 'FOO--BAR'._pathify
    end
    
    def test_with_multiple_punctuation_following_lowercase
      assert_equal 'foo_', %q{foo'"}._pathify
    end
    
    def test_with_multiple_punctuation_following_uppercase
      assert_equal 'foo_', %q{FOO'"}._pathify
    end
    
    def test_with_multiple_spaces_preceding_lowercase
      assert_equal '_foo', '  foo'._pathify
    end
    
    def test_with_multiple_spaces_preceding_uppercase
      assert_equal '_foo', '  FOO'._pathify
    end
    
    def test_with_multiple_spaces_within_lowercase
      assert_equal 'foo_bar', 'foo  bar'._pathify
    end
    
    def test_with_multiple_spaces_within_uppercase
      assert_equal 'foo_bar', 'FOO  BAR'._pathify
    end
    
    def test_with_multiple_spaces_following_lowercase
      assert_equal 'foo_', 'foo  '._pathify
    end
    
    def test_with_multiple_spaces_following_uppercase
      assert_equal 'foo_', 'FOO  '._pathify
    end
    
  end
  
  class UNDERSCORETypify < Test::Unit::TestCase
    
    def test_with_lowercase_word
      assert_equal 'Foo', 'foo'._typify
    end
    
    def test_with_uppercase_word
      assert_equal 'FOO', 'FOO'._typify
    end
    
    def test_with_underscore_delimited_words
      assert_equal 'FooBar', 'foo_bar'._typify
    end
    
    def test_with_underscore_delimited_single_character_words
      assert_equal 'ThisIsATest', 'this_is_a_test'._typify
    end
    
    def test_with_double_underscore_delimited_words
      assert_equal 'Foo_Bar', 'foo__bar'._typify
    end
    
    def test_with_slash_delimited_words
      assert_equal 'Foo::Bar', 'foo/bar'._typify
    end
    
    def test_with_backslash_delimited_words
      assert_equal 'Foo::Bar', 'foo\bar'._typify
    end
    
    def test_with_double_slash_delimited_words
      assert_equal 'Foo::Bar', 'foo//bar'._typify
    end
    
    def test_with_double_backslash_delimited_words
      assert_equal 'Foo::Bar', 'foo//bar'._typify
    end
    
    def test_with_camel_case
      assert_equal 'FooBar', 'FooBar'._typify
    end
    
    def test_with_colon_delimited_camel_case_terms
      assert_equal 'FooBar::BazBat', 'FooBar:BazBat'._typify
    end
    
    def test_with_slash_delimited_underscore_terms
      assert_equal 'FooBar::BazBat', 'foo_bar/baz_bat'._typify
    end
    
    def test_with_backslash_delimited_underscore_terms
      assert_equal 'FooBar::BazBat', 'foo_bar\baz_bat'._typify
    end
    
    def test_with_colon_delimited_words
      assert_equal 'Foo::Bar', 'foo:bar'._typify
    end
    
    def test_with_double_colon_delimited_camel_case_terms
      assert_equal 'FooBar::BazBat', 'FooBar::BazBat'._typify
    end
    
    def test_with_leading_acronym
      assert_equal 'FBIOrTheFeds', 'FBIOrTheFeds'._typify
    end
    
    def test_with_embedded_acronym
      assert_equal 'TheFBIOrTheFeds', 'TheFBIOrTheFeds'._typify
    end
    
    def test_with_trailing_acronym
      assert_equal 'TheFedsOrTheFBI', 'TheFedsOrTheFBI'._typify
    end
    
    def test_with_numerals_preceding_lowercase
      assert_equal '123abc', '123abc'._typify
    end
    
    def test_with_numerals_preceding_uppercase
      assert_equal '123ABC', '123ABC'._typify
    end
    
    def test_with_numerals_within_lowercase
      assert_equal 'Abc123def', 'abc123def'._typify
    end
    
    def test_with_numerals_within_uppercase
      assert_equal 'ABC123DEF', 'ABC123DEF'._typify
    end
    
    def test_with_numerals_following_lowercase
      assert_equal 'Abc123', 'abc123'._typify
    end
    
    def test_with_numerals_following_uppercase
      assert_equal 'ABC123', 'ABC123'._typify
    end
    
    def test_with_multiple_punctuation_preceding_lowercase
      assert_equal 'Foo', %q{"'foo}._typify
    end
    
    def test_with_multiple_punctuation_preceding_uppercase
      assert_equal 'FOO', %q{"'FOO}._typify
    end
    
    def test_with_multiple_punctuation_within_lowercase
      assert_equal 'Foo_Bar', 'foo--bar'._typify
    end
    
    def test_with_multiple_punctuation_within_uppercase
      assert_equal 'FOO_BAR', 'FOO--BAR'._typify
    end
    
    def test_with_multiple_punctuation_following_lowercase
      assert_equal 'Foo', %q{foo'"}._typify
    end
    
    def test_with_multiple_punctuation_following_uppercase
      assert_equal 'FOO', %q{FOO'"}._typify
    end
    
    def test_with_multiple_spaces_preceding_lowercase
      assert_equal 'Foo', '  foo'._typify
    end
    
    def test_with_multiple_spaces_preceding_uppercase
      assert_equal 'FOO', '  FOO'._typify
    end
    
    def test_with_multiple_spaces_within_lowercase
      assert_equal 'Foo_Bar', 'foo  bar'._typify
    end
    
    def test_with_multiple_spaces_within_uppercase
      assert_equal 'FOO_BAR', 'FOO  BAR'._typify
    end
    
    def test_with_multiple_spaces_following_lowercase
      assert_equal 'Foo', 'foo  '._typify
    end
    
    def test_with_multiple_spaces_following_uppercase
      assert_equal 'FOO', 'FOO  '._typify
    end
    
  end
  
  class UNDERSCOREVariablize < Test::Unit::TestCase
    
    def test_with_lowercase_word
      assert_equal 'foo', 'foo'._variablize
    end
    
    def test_with_uppercase_word
      assert_equal 'foo', 'FOO'._variablize
    end
    
    def test_with_underscore_delimited_words
      assert_equal 'foo_bar', 'foo_bar'._variablize
    end
    
    def test_with_underscore_delimited_single_character_words
      assert_equal 'this_is_a_test', 'this_is_a_test'._variablize
    end
    
    def test_with_double_underscore_delimited_words
      assert_equal 'foo_bar', 'foo__bar'._variablize
    end
    
    def test_with_slash_delimited_words
      assert_equal 'foo_bar', 'foo/bar'._variablize
    end
    
    def test_with_double_slash_delimited_words
      assert_equal 'foo__bar', 'foo//bar'._variablize
    end
    
    def test_with_camel_case
      assert_equal 'foo_bar', 'FooBar'._variablize
    end
    
    def test_with_colon_delimited_camel_case_terms
      assert_equal 'foo_bar_baz_bat',
                   'FooBar:BazBat'._variablize
    end
    
    def test_with_slash_delimited_underscore_terms
      assert_equal 'foo_bar_baz_bat',
                   'foo_bar/baz_bat'._variablize
    end
    
    def test_with_backslash_delimited_underscore_terms
      assert_equal 'foo_bar_baz_bat',
                   'foo_bar\baz_bat'._variablize
    end
    
    def test_with_colon_delimited_words
      assert_equal 'foo_bar', 'foo:bar'._variablize
    end
    
    def test_with_double_colon_delimited_camel_case_terms
      assert_equal 'foo_bar_baz_bat',
                   'FooBar::BazBat'._variablize
    end
    
    def test_with_leading_acronym
      assert_equal 'fbi_or_the_feds',
                   'FBIOrTheFeds'._variablize
    end
    
    def test_with_embedded_acronym
      assert_equal 'the_fbi_or_the_feds',
                   'TheFBIOrTheFeds'._variablize
    end
    
    def test_with_trailing_acronym
      assert_equal 'the_feds_or_the_fbi',
                   'TheFedsOrTheFBI'._variablize
    end
    
    def test_with_numerals_preceding_lowercase
      assert_equal '_123abc', '123abc'._variablize
    end
    
    def test_with_numerals_preceding_uppercase
      assert_equal '_123_abc', '123ABC'._variablize
    end
    
    def test_with_numerals_within_lowercase
      assert_equal 'abc_123def', 'abc123def'._variablize
    end
    
    def test_with_numerals_within_uppercase
      assert_equal 'abc123_def', 'ABC123DEF'._variablize
    end
    
    def test_with_numerals_following_lowercase
      assert_equal 'abc_123', 'abc123'._variablize
    end
    
    def test_with_numerals_following_uppercase
      assert_equal 'abc123', 'ABC123'._variablize
    end
    
    def test_with_multiple_punctuation_preceding_lowercase
      assert_equal 'foo', %q{"'foo}._variablize
    end
    
    def test_with_multiple_punctuation_preceding_uppercase
      assert_equal 'foo', %q{"'FOO}._variablize
    end
    
    def test_with_multiple_punctuation_within_lowercase
      assert_equal 'foo_bar', 'foo--bar'._variablize
    end
    
    def test_with_multiple_punctuation_within_uppercase
      assert_equal 'foo_bar', 'FOO--BAR'._variablize
    end
    
    def test_with_multiple_punctuation_following_lowercase
      assert_equal 'foo', %q{foo'"}._variablize
    end
    
    def test_with_multiple_punctuation_following_uppercase
      assert_equal 'foo', %q{FOO'"}._variablize
    end
    
    def test_with_multiple_spaces_preceding_lowercase
      assert_equal 'foo', '  foo'._variablize
    end
    
    def test_with_multiple_spaces_preceding_uppercase
      assert_equal 'foo', '  FOO'._variablize
    end
    
    def test_with_multiple_spaces_within_lowercase
      assert_equal 'foo_bar', 'foo  bar'._variablize
    end
    
    def test_with_multiple_spaces_within_uppercase
      assert_equal 'foo_bar', 'FOO  BAR'._variablize
    end
    
    def test_with_multiple_spaces_following_lowercase
      assert_equal 'foo', 'foo  '._variablize
    end
    
    def test_with_multiple_spaces_following_uppercase
      assert_equal 'foo', 'FOO  '._variablize
    end
    
  end
  
end

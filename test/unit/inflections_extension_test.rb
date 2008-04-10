require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/inflections_extension")
require 'test/unit'

module Trapeze::InflectionsExtensionTest
  
  class Pathify < Test::Unit::TestCase
    
    def test_with_lowercase_word
      assert_equal 'foo', 'foo'.pathify
    end
    
    def test_with_uppercase_word
      assert_equal 'foo', 'FOO'.pathify
    end
    
    def test_with_underscore_delimited_words
      assert_equal 'foo_bar', 'foo_bar'.pathify
    end
    
    def test_with_double_underscore_delimited_words
      assert_equal 'foo_bar', 'foo__bar'.pathify
    end
    
    def test_with_slash_delimited_words
      assert_equal 'foo/bar', 'foo/bar'.pathify
    end
    
    def test_with_double_slash_delimited_words
      assert_equal 'foo//bar', 'foo//bar'.pathify
    end
    
    def test_with_camel_case
      assert_equal 'foo_bar', 'FooBar'.pathify
    end
    
    def test_with_colon_delimited_camel_case_terms
      assert_equal 'foo_bar/baz_bat', 'FooBar:BazBat'.pathify
    end
    
    def test_with_colon_delimited_words
      assert_equal 'foo/bar', 'foo:bar'.pathify
    end
    
    def test_with_double_colon_delimited_camel_case_terms
      assert_equal 'foo_bar/baz_bat', 'FooBar::BazBat'.pathify
    end
    
    def test_with_leading_acronym
      assert_equal 'fbi_or_the_feds', 'FBIOrTheFeds'.pathify
    end
    
    def test_with_embedded_acronym
      assert_equal 'the_fbi_or_the_feds', 'TheFBIOrTheFeds'.pathify
    end
    
    def test_with_trailing_acronym
      assert_equal 'the_feds_or_the_fbi', 'TheFedsOrTheFBI'.pathify
    end
    
    def test_with_numerals_preceding_lowercase
      assert_equal '123abc', '123abc'.pathify
    end
    
    def test_with_numerals_preceding_uppercase
      assert_equal '123_abc', '123ABC'.pathify
    end
    
    def test_with_numerals_within_lowercase
      assert_equal 'abc_123def', 'abc123def'.pathify
    end
    
    def test_with_numerals_within_uppercase
      assert_equal 'abc123_def', 'ABC123DEF'.pathify
    end
    
    def test_with_numerals_following_lowercase
      assert_equal 'abc_123', 'abc123'.pathify
    end
    
    def test_with_numerals_following_uppercase
      assert_equal 'abc123', 'ABC123'.pathify
    end
    
    def test_with_multiple_punctuation_preceding_lowercase
      assert_equal '_foo', %q{"'foo}.pathify
    end
    
    def test_with_multiple_punctuation_preceding_uppercase
      assert_equal '_foo', %q{"'FOO}.pathify
    end
    
    def test_with_multiple_punctuation_within_lowercase
      assert_equal 'foo_bar', 'foo--bar'.pathify
    end
    
    def test_with_multiple_punctuation_within_uppercase
      assert_equal 'foo_bar', 'FOO--BAR'.pathify
    end
    
    def test_with_multiple_punctuation_following_lowercase
      assert_equal 'foo_', %q{foo'"}.pathify
    end
    
    def test_with_multiple_punctuation_following_uppercase
      assert_equal 'foo_', %q{FOO'"}.pathify
    end
    
    def test_with_multiple_spaces_preceding_lowercase
      assert_equal '_foo', '  foo'.pathify
    end
    
    def test_with_multiple_spaces_preceding_uppercase
      assert_equal '_foo', '  FOO'.pathify
    end
    
    def test_with_multiple_spaces_within_lowercase
      assert_equal 'foo_bar', 'foo  bar'.pathify
    end
    
    def test_with_multiple_spaces_within_uppercase
      assert_equal 'foo_bar', 'FOO  BAR'.pathify
    end
    
    def test_with_multiple_spaces_following_lowercase
      assert_equal 'foo_', 'foo  '.pathify
    end
    
    def test_with_multiple_spaces_following_uppercase
      assert_equal 'foo_', 'FOO  '.pathify
    end
    
  end
  
  class Typify < Test::Unit::TestCase
    
    def test_with_lowercase_word
      assert_equal 'Foo', 'foo'.typify
    end
    
    def test_with_uppercase_word
      assert_equal 'FOO', 'FOO'.typify
    end
    
    def test_with_underscore_delimited_words
      assert_equal 'FooBar', 'foo_bar'.typify
    end
    
    def test_with_double_underscore_delimited_words
      assert_equal 'Foo_Bar', 'foo__bar'.typify
    end
    
    def test_with_slash_delimited_words
      assert_equal 'Foo::Bar', 'foo/bar'.typify
    end
    
    def test_with_backslash_delimited_words
      assert_equal 'Foo::Bar', 'foo\bar'.typify
    end
    
    def test_with_double_slash_delimited_words
      assert_equal 'Foo::Bar', 'foo//bar'.typify
    end
    
    def test_with_double_backslash_delimited_words
      assert_equal 'Foo::Bar', 'foo//bar'.typify
    end
    
    def test_with_camel_case
      assert_equal 'FooBar', 'FooBar'.typify
    end
    
    def test_with_colon_delimited_camel_case_terms
      assert_equal 'FooBar::BazBat', 'FooBar:BazBat'.typify
    end
    
    def test_with_slash_delimited_underscore_terms
      assert_equal 'FooBar::BazBat', 'foo_bar/baz_bat'.typify
    end
    
    def test_with_backslash_delimited_underscore_terms
      assert_equal 'FooBar::BazBat', 'foo_bar\baz_bat'.typify
    end
    
    def test_with_colon_delimited_words
      assert_equal 'Foo::Bar', 'foo:bar'.typify
    end
    
    def test_with_double_colon_delimited_camel_case_terms
      assert_equal 'FooBar::BazBat', 'FooBar::BazBat'.typify
    end
    
    def test_with_leading_acronym
      assert_equal 'FBIOrTheFeds', 'FBIOrTheFeds'.typify
    end
    
    def test_with_embedded_acronym
      assert_equal 'TheFBIOrTheFeds', 'TheFBIOrTheFeds'.typify
    end
    
    def test_with_trailing_acronym
      assert_equal 'TheFedsOrTheFBI', 'TheFedsOrTheFBI'.typify
    end
    
    def test_with_numerals_preceding_lowercase
      assert_equal '_123abc', '123abc'.typify
    end
    
    def test_with_numerals_preceding_uppercase
      assert_equal '_123ABC', '123ABC'.typify
    end
    
    def test_with_numerals_within_lowercase
      assert_equal 'Abc123def', 'abc123def'.typify
    end
    
    def test_with_numerals_within_uppercase
      assert_equal 'ABC123DEF', 'ABC123DEF'.typify
    end
    
    def test_with_numerals_following_lowercase
      assert_equal 'Abc123', 'abc123'.typify
    end
    
    def test_with_numerals_following_uppercase
      assert_equal 'ABC123', 'ABC123'.typify
    end
    
    def test_with_multiple_punctuation_preceding_lowercase
      assert_equal 'Foo', %q{"'foo}.typify
    end
    
    def test_with_multiple_punctuation_preceding_uppercase
      assert_equal 'FOO', %q{"'FOO}.typify
    end
    
    def test_with_multiple_punctuation_within_lowercase
      assert_equal 'Foo_Bar', 'foo--bar'.typify
    end
    
    def test_with_multiple_punctuation_within_uppercase
      assert_equal 'FOO_BAR', 'FOO--BAR'.typify
    end
    
    def test_with_multiple_punctuation_following_lowercase
      assert_equal 'Foo', %q{foo'"}.typify
    end
    
    def test_with_multiple_punctuation_following_uppercase
      assert_equal 'FOO', %q{FOO'"}.typify
    end
    
    def test_with_multiple_spaces_preceding_lowercase
      assert_equal 'Foo', '  foo'.typify
    end
    
    def test_with_multiple_spaces_preceding_uppercase
      assert_equal 'FOO', '  FOO'.typify
    end
    
    def test_with_multiple_spaces_within_lowercase
      assert_equal 'Foo_Bar', 'foo  bar'.typify
    end
    
    def test_with_multiple_spaces_within_uppercase
      assert_equal 'FOO_BAR', 'FOO  BAR'.typify
    end
    
    def test_with_multiple_spaces_following_lowercase
      assert_equal 'Foo', 'foo  '.typify
    end
    
    def test_with_multiple_spaces_following_uppercase
      assert_equal 'FOO', 'FOO  '.typify
    end
    
  end
  
  class Variablize < Test::Unit::TestCase
    
    def test_with_lowercase_word
      assert_equal 'foo', 'foo'.variablize
    end
    
    def test_with_uppercase_word
      assert_equal 'foo', 'FOO'.variablize
    end
    
    def test_with_underscore_delimited_words
      assert_equal 'foo_bar', 'foo_bar'.variablize
    end
    
    def test_with_double_underscore_delimited_words
      assert_equal 'foo_bar', 'foo__bar'.variablize
    end
    
    def test_with_slash_delimited_words
      assert_equal 'foo_bar', 'foo/bar'.variablize
    end
    
    def test_with_double_slash_delimited_words
      assert_equal 'foo__bar', 'foo//bar'.variablize
    end
    
    def test_with_camel_case
      assert_equal 'foo_bar', 'FooBar'.variablize
    end
    
    def test_with_colon_delimited_camel_case_terms
      assert_equal 'foo_bar_baz_bat',
                   'FooBar:BazBat'.variablize
    end
    
    def test_with_slash_delimited_underscore_terms
      assert_equal 'foo_bar_baz_bat',
                   'foo_bar/baz_bat'.variablize
    end
    
    def test_with_backslash_delimited_underscore_terms
      assert_equal 'foo_bar_baz_bat',
                   'foo_bar\baz_bat'.variablize
    end
    
    def test_with_colon_delimited_words
      assert_equal 'foo_bar', 'foo:bar'.variablize
    end
    
    def test_with_double_colon_delimited_camel_case_terms
      assert_equal 'foo_bar_baz_bat',
                   'FooBar::BazBat'.variablize
    end
    
    def test_with_leading_acronym
      assert_equal 'fbi_or_the_feds',
                   'FBIOrTheFeds'.variablize
    end
    
    def test_with_embedded_acronym
      assert_equal 'the_fbi_or_the_feds',
                   'TheFBIOrTheFeds'.variablize
    end
    
    def test_with_trailing_acronym
      assert_equal 'the_feds_or_the_fbi',
                   'TheFedsOrTheFBI'.variablize
    end
    
    def test_with_numerals_preceding_lowercase
      assert_equal '_123abc', '123abc'.variablize
    end
    
    def test_with_numerals_preceding_uppercase
      assert_equal '_123_abc', '123ABC'.variablize
    end
    
    def test_with_numerals_within_lowercase
      assert_equal 'abc_123def', 'abc123def'.variablize
    end
    
    def test_with_numerals_within_uppercase
      assert_equal 'abc123_def', 'ABC123DEF'.variablize
    end
    
    def test_with_numerals_following_lowercase
      assert_equal 'abc_123', 'abc123'.variablize
    end
    
    def test_with_numerals_following_uppercase
      assert_equal 'abc123', 'ABC123'.variablize
    end
    
    def test_with_multiple_punctuation_preceding_lowercase
      assert_equal '_foo', %q{"'foo}.variablize
    end
    
    def test_with_multiple_punctuation_preceding_uppercase
      assert_equal '_foo', %q{"'FOO}.variablize
    end
    
    def test_with_multiple_punctuation_within_lowercase
      assert_equal 'foo_bar', 'foo--bar'.variablize
    end
    
    def test_with_multiple_punctuation_within_uppercase
      assert_equal 'foo_bar', 'FOO--BAR'.variablize
    end
    
    def test_with_multiple_punctuation_following_lowercase
      assert_equal 'foo_', %q{foo'"}.variablize
    end
    
    def test_with_multiple_punctuation_following_uppercase
      assert_equal 'foo_', %q{FOO'"}.variablize
    end
    
    def test_with_multiple_spaces_preceding_lowercase
      assert_equal '_foo', '  foo'.variablize
    end
    
    def test_with_multiple_spaces_preceding_uppercase
      assert_equal '_foo', '  FOO'.variablize
    end
    
    def test_with_multiple_spaces_within_lowercase
      assert_equal 'foo_bar', 'foo  bar'.variablize
    end
    
    def test_with_multiple_spaces_within_uppercase
      assert_equal 'foo_bar', 'FOO  BAR'.variablize
    end
    
    def test_with_multiple_spaces_following_lowercase
      assert_equal 'foo_', 'foo  '.variablize
    end
    
    def test_with_multiple_spaces_following_uppercase
      assert_equal 'foo_', 'FOO  '.variablize
    end
    
  end
  
end

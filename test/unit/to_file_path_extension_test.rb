require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/to_file_path_extension")
require 'test/unit'

module Trapeze::ToFilePathExtensionTest
  
  class ClassWithOneWordName < Test::Unit::TestCase
    
    class Foo; end
    
    def test_should_return_expected_file_path_when_sent_to_file_path
      expected = 'trapeze/to_file_path_extension_test/class_with_one_word_name/foo.rb'
      assert_equal expected, Foo.to_file_path
    end
    
  end
  
  class ClassWithTwoWordName < Test::Unit::TestCase
    
    class FooBar; end
    
    def test_should_return_expected_file_path_when_sent_to_file_path
      expected = 'trapeze/to_file_path_extension_test/class_with_two_word_name/foo_bar.rb'
      assert_equal expected, FooBar.to_file_path
    end
    
  end
  
  class ClassWithAcronymName < Test::Unit::TestCase
    
    class FBI; end
    
    def test_should_return_expected_file_path_when_sent_to_file_path
      expected = 'trapeze/to_file_path_extension_test/class_with_acronym_name/fbi.rb'
      assert_equal expected, FBI.to_file_path
    end
    
  end
  
  class ClassWithAcronymEmbeddedInName < Test::Unit::TestCase
    
    class TheBigBadFBIDude; end
    
    def test_should_return_expected_file_path_when_sent_to_file_path
      expected = 'trapeze/to_file_path_extension_test/class_with_acronym_embedded_in_name/the_big_bad_fbi_dude.rb'
      assert_equal expected, TheBigBadFBIDude.to_file_path
    end
    
  end
  
  class ClassWithEmbeddedNumeralsInName < Test::Unit::TestCase
    
    class Foo123Bar; end
    
    def test_should_return_expected_file_path_when_sent_to_file_path
      expected = 'trapeze/to_file_path_extension_test/class_with_embedded_numerals_in_name/foo123_bar.rb'
      assert_equal expected, Foo123Bar.to_file_path
    end
    
  end
  
  class ClassWithEmbeddedUnderscoreInName < Test::Unit::TestCase
    
    class Foo_Bar; end
    
    def test_should_return_expected_file_path_when_sent_to_file_path
      expected = 'trapeze/to_file_path_extension_test/class_with_embedded_underscore_in_name/foo_bar.rb'
      assert_equal expected, Foo_Bar.to_file_path
    end
    
  end
  
  class ClassWithRepeatedUnderscoresEmbeddedInName < Test::Unit::TestCase
    
    class Foo__Bar; end
    
    def test_should_return_expected_file_path_when_sent_to_file_path
      expected = 'trapeze/to_file_path_extension_test/class_with_repeated_underscores_embedded_in_name/foo__bar.rb'
      assert_equal expected, Foo__Bar.to_file_path
    end
    
  end
  
end

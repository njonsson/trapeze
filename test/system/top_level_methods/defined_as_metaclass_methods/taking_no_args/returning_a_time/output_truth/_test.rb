# This file was automatically generated by Trapeze, the safety-net generator for
# Ruby. Visit http://trapeze.rubyforge.org/ for more information.

require 'test/unit'

class Test_ < Test::Unit::TestCase
  
  class << self
    
    def top_level_method_calls
      @top_level_method_calls ||= {}
    end
    
  end
  
  def test_should_return_sat_feb_02_08_02_02_utc_2002_when_sent_bar
    assert_equal Time.utc(2002, 2, 2, 8, 2, 2, 2), Test_.top_level_method_calls[:bar].call
  end
  
  def test_should_return_mon_jan_01_07_01_01_utc_2001_when_sent_foo
    assert_equal Time.utc(2001, 1, 1, 7, 1, 1, 1), Test_.top_level_method_calls[:foo].call
  end
  
end

Test_.top_level_method_calls[:bar] = lambda { bar }
Test_.top_level_method_calls[:foo] = lambda { foo }

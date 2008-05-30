class Foo
  
  class Bar
    
    def initialize
      @my_state1 = :something1
      @my_state2 = :something2
    end
    
  end
  
  class Baz
    
    def initialize
      @my_state1 = :something_else1
      @my_state2 = :something_else2
    end
    
  end
  
  def bar
    Bar.new
  end
  
  def baz
    Baz.new
  end
  
end

class Foo
  
  class Bar
    
    def initialize
      @my_state = :something
    end
    
  end
  
  class Baz
    
    def initialize
      @my_state = :something_else
    end
    
  end
  
  def bar
    Bar.new
  end
  
  def baz
    Baz.new
  end
  
end

class Bat
  
  class Pwop
    
    def initialize
      @my_state = :something_else_again
    end
    
  end
  
  class Ding
    
    def initialize
      @my_state = :something_else_entirely
    end
    
  end
  
  def pwop
    Pwop.new
  end
  
  def ding
    Ding.new
  end
  
end

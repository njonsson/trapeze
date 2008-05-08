class Bat
  
  class Pwop
    
    def initialize
      @my_state1 = :something_else_again1
      @my_state2 = :something_else_again2
    end
    
  end
  
  class Ding
    
    def initialize
      @my_state1 = :something_else_entirely1
      @my_state2 = :something_else_entirely2
    end
    
  end
  
  def pwop
    Pwop.new
  end
  
  def ding
    Ding.new
  end
  
end

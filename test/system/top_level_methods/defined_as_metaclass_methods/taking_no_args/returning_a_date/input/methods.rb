require 'date'

class << self
  
  def foo
    Date.civil 2001, 1, 1
  end
  
  def bar
    Date.civil 2002, 2, 2
  end
  
end

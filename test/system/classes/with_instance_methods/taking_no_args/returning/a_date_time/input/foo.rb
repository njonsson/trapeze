require 'date'

class Foo
  
  def bar
    DateTime.civil 2001, 1, 1, 1, 1, 1
  end
  
  def baz
    DateTime.civil 2002, 2, 2, 2, 2, 2
  end
  
end

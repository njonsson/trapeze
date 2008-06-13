module Foo
  
  def bar
    raise RuntimeError, 'this error also was raised intentionally'
  end
  
  def baz
    'BAZ!'
  end
  
end

class Foo
  
  def bar
    'BAR!'
  end
  
  raise RuntimeError, 'this error also was raised intentionally'
  
  def baz
    'BAZ!'
  end
  
end

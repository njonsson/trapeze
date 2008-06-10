class Foo
  
  def bar
    'BAR!'
  end
  
  raise NoMethodError, 'this error also was raised intentionally'
  
  def baz
    'BAZ!'
  end
  
end

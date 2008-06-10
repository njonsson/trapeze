class Foo
  
  def bar
    raise NoMethodError, 'this error also was raised intentionally'
  end
  
  def baz
    'BAZ!'
  end
  
end

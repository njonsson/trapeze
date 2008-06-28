class << self
  
  def foo
    raise NoMethodError, 'this error was raised intentionally'
  end
  
  def bar
    'BAR!'
  end
  
end

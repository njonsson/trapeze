class Array
  
  def baz
    raise NoMethodError, 'this error also was raised intentionally'
  end
  
  def bat
    'BAT!'
  end
  
end

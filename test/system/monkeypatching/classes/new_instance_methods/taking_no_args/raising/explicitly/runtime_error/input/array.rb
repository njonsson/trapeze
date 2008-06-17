class Array
  
  def baz
    raise RuntimeError, 'this error also was raised intentionally'
  end
  
  def bat
    'BAT!'
  end
  
end

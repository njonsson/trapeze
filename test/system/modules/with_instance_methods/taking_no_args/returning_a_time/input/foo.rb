module Foo
  
  def bar
    Time.local(2001, 1, 1, 1, 1, 1, 1) + cst_offset
  end
  
  def baz
    Time.local(2002, 2, 2, 2, 2, 2, 2) + cst_offset
  end
  
private
  
  def cst_offset
    # Because the truth test files were created in Central Standard Time.
    Time.now.utc_offset + 18000
  end
  
end

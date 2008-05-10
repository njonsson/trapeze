module Bat
  
  def pwop
    Time.local(2003, 3, 3, 3, 3, 3, 3) + cst_offset
  end
  
  def ding
    Time.local(2004, 4, 4, 4, 4, 4, 4) + cst_offset
  end
  
private
  
  def cst_offset
    # Because the truth test files were created in Central Standard Time.
    Time.now.utc_offset + 18000
  end
  
end

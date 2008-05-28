require 'bigdecimal'

class << self
  
  def foo
      BigDecimal.new '0.' + ('7' * 384)
  end
  
  def bar
      BigDecimal.new '0.' + ('8' * 384)
  end
  
end

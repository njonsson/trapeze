require 'bigdecimal'

module Bat
  
  def pwop
    BigDecimal.new '0.' + ('8' * 384)
  end
  
  def ding
    BigDecimal.new '0.' + ('9' * 384)
  end
  
end

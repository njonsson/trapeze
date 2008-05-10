require 'bigdecimal'

module Foo
  
  def bar
    BigDecimal.new '0.' + ('6' * 384)
  end
  
  def baz
    BigDecimal.new '0.' + ('7' * 384)
  end
  
end

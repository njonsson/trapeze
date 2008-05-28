require 'bigdecimal'

def self.foo
    BigDecimal.new '0.' + ('7' * 384)
end

def self.bar
    BigDecimal.new '0.' + ('8' * 384)
end

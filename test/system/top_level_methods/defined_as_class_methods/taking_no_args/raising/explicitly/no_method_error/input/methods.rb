def self.foo
  raise NoMethodError, 'this error was raised intentionally'
end

def self.bar
  'BAR!'
end

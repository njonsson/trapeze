def self.foo
  raise RuntimeError, 'this error was raised intentionally'
end

def self.bar
  'BAR!'
end

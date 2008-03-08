Dir.glob("#{File.dirname __FILE__}/unit/**/*_test.rb") do |f|
  require File.expand_path(f)
end

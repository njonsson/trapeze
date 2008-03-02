# Trapeze is a regression safety-net generator for Ruby.
module Trapeze; end

Dir.glob("#{File.dirname __FILE__}/lib/**/*.rb") do |source_file|
  require File.expand_path(source_file)
end

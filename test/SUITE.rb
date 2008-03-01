Dir.glob("#{File.dirname __FILE__}/{integration,system,unit}/**/*.rb") do |source_file|
  require File.expand_path(source_file)
end

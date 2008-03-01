require 'rake'
require 'rake/rdoctask'

desc 'Generate documentation for Trapeze.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Trapeze'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('README-TO-RUN-TESTS')
  rdoc.rdoc_files.include('trapeze.rb')
  rdoc.rdoc_files.include('MIT-LICENSE')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.options << '--line-numbers' << '--inline-source'
end

require 'rake'
require 'rake/rdoctask'
require 'rake/testtask'
require 'rcov/rcovtask'

task :default => :test

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = 'Trapeze'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('trapeze.rb')
  rdoc.rdoc_files.include('MIT-LICENSE')
  rdoc.rdoc_files.include('bin/trap')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.options << '--line-numbers' << '--inline-source'
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.verbose = true
  t.test_files = 'test/SUITE.rb'
end

namespace :test do
  desc 'Create a code coverage report for the tests'
  Rcov::RcovTask.new(:coverage) do |t|
    t.test_files = 'test/SUITE.rb'
    t.verbose = true
  end
  
  Rake::TestTask.new(:unit) do |t|
    t.test_files = 'test/UNIT_TESTS.rb'
    t.verbose = true
  end
  
  namespace :unit do
    desc 'Create a code coverage report for the tests in test/unit'
    Rcov::RcovTask.new(:coverage) do |t|
      t.output_dir = 'coverage-unit'
      t.test_files = 'test/UNIT_TESTS.rb'
      t.verbose = true
    end
  end
  
  Rake::TestTask.new(:system) do |t|
    t.test_files = 'test/SYSTEM_TESTS.rb'
    t.verbose = true
  end
  
  namespace :system do
    desc 'Create a code coverage report for the tests in test/system'
    Rcov::RcovTask.new(:coverage) do |t|
      t.output_dir = 'coverage-system'
      t.test_files = 'test/SYSTEM_TESTS.rb'
      t.verbose = true
    end
  end
end

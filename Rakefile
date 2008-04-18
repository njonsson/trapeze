require 'rake'
require 'rake/rdoctask'
require 'rake/testtask'
begin
  require 'rcov/rcovtask'
  rcov_missing = false
rescue LoadError
  rcov_missing = true
  $stderr.puts '***********************************************************'
  $stderr.puts 'RCov tasks are not available because RCov is not installed.'
  $stderr.puts "To install RCov, type 'gem install rcov'."
  $stderr.puts '***********************************************************'
end

task :default => :test

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = 'Trapeze'
  rdoc.rdoc_files.include('README')
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
  unless rcov_missing
    desc 'Create a code coverage report for the tests'
    Rcov::RcovTask.new(:coverage) do |t|
      t.test_files = 'test/SUITE.rb'
      t.verbose = true
    end
  end
  
  Rake::TestTask.new(:unit) do |t|
    t.test_files = 'test/UNIT_TESTS.rb'
    t.verbose = true
  end
  
  unless rcov_missing
    namespace :unit do
      desc 'Create a code coverage report for the tests in test/unit'
      Rcov::RcovTask.new(:coverage) do |t|
        t.output_dir = 'coverage-unit'
        t.test_files = 'test/UNIT_TESTS.rb'
        t.verbose = true
      end
    end
  end
  
  Rake::TestTask.new(:system) do |t|
    t.test_files = 'test/SYSTEM_TESTS.rb'
    t.verbose = true
  end
  
  namespace :system do
    unless rcov_missing
      desc 'Create a code coverage report for the tests in test/system'
      Rcov::RcovTask.new(:coverage) do |t|
        t.output_dir = 'coverage-system'
        t.test_files = 'test/SYSTEM_TESTS.rb'
        t.verbose = true
      end
    end
    
    desc 'Run generated system tests'
    task :generated do
      Dir.glob("#{File.dirname __FILE__}/test/system/**/output/**/SUITE.rb") do |f|
        system %Q(ruby #{File.expand_path f})
      end
    end
    
    desc 'Run truth-file system tests'
    task :truth do
      Dir.glob("#{File.dirname __FILE__}/test/system/**/output_truth/**/SUITE.rb") do |f|
        system %Q(ruby #{File.expand_path f})
      end
    end
  end
end

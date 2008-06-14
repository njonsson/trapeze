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
  rdoc.rdoc_files.include('bin/trp')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.options << '--line-numbers' << '--inline-source'
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.verbose = true
  t.test_files = 'test/SUITE.rb'
end

namespace :test do
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
  
  def run_system_tests(output_dir)
    pattern = "#{File.dirname __FILE__}/test/system/**/#{output_dir}/SUITE.rb"
    ruby_exe = (RUBY_PLATFORM =~ /mswin/i) ? 'ruby' : '/usr/bin/env ruby'
    Dir.glob(pattern) do |f|
      quiet_suite = File.expand_path("#{File.dirname f}/../SUITE_quiet.rb")
      if File.file?(quiet_suite)
        $output_dir = output_dir
        system %Q(#{ruby_exe} ) +
               %Q(-e "$output_dir = '#{output_dir}'; load '#{quiet_suite}'")
      else
        system %Q(#{ruby_exe} "#{File.expand_path f}")
      end
    end
  end
  
  namespace :system do
    desc 'Run generated system tests'
    task :generated do
      run_system_tests 'output'
    end
    
    desc 'Run truth-file system tests'
    task :truth do
      run_system_tests 'output_truth'
    end
  end
end

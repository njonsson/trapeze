# Defines Trapeze::SuiteGenerators::TestUnit.

require File.expand_path("#{File.dirname __FILE__}/../suite_generators")
require File.expand_path("#{File.dirname __FILE__}/../suite_generators/generator_base")
require File.expand_path("#{File.dirname __FILE__}/../name_extension")

# Generates Ruby source files containing Test::Unit test cases.
class Trapeze::SuiteGenerators::TestUnit <
      Trapeze::SuiteGenerators::GeneratorBase
  
private
  
  def generate_class_file!(kase)
    File.open("#{path}/#{kase.class_or_module.name.gsub '::', '_'}_test.rb", 'a+') do |f|
      f.puts kase.class_or_module.name
    end
  end
  
  def generate_methods_file!
    File.open("#{path}/_test.rb", 'a+') do |f|
      f.print <<-end_print
#{file_boilerplate}
require 'test/unit'

class Test_ < Test::Unit::TestCase
  
  def test_foo_returns_nil
    assert_nil foo
  end
  
end
      end_print
    end
  end
  
  def generate_suite_file!
    File.open("#{path}/SUITE.rb", 'w') do |f|
      f.print <<-end_print
#{file_boilerplate}
Dir.glob("\#{File.dirname __FILE__}/../input/**/*.rb") do |source_file|
  require File.expand_path(source_file)
end

Dir.glob("\#{File.dirname __FILE__}/**/*_test.rb") do |test_file|
  require File.expand_path(test_file)
end
      end_print
    end
  end
  
end

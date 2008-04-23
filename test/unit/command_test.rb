require File.expand_path("#{File.dirname __FILE__}/../test")
require File.expand_path("#{File.dirname __FILE__}/../../lib/trapeze/command")
require 'test/unit'

module Trapeze::CommandTest
  
  class WithNoArgs < Test::Unit::TestCase
    
    def setup
      @args = Trapeze::Command.new
    end
    
    def test_should_return_empty_array_when_sent_args
      assert_equal [], @args.args
    end
    
    def test_should_return_empty_hash_when_sent_errors
      assert_equal({}, @args.errors)
    end
    
    def test_should_return_empty_hash_when_sent_options
      assert_equal({}, @args.options)
    end
    
    def test_should_return_true_when_sent_validQUESTION
      assert_equal true, @args.valid?
    end
    
  end
  
  class WithLongOptionArgAndWithoutValidOptions < Test::Unit::TestCase
    
    def setup
      @args = Trapeze::Command.new(:args => '--this-option-is-not-valid')
    end
    
    def test_should_return_array_containing_expected_args_when_sent_args
      assert_equal ['--this-option-is-not-valid'], @args.args
    end
    
    def test_should_return_hash_containing_expected_error_when_sent_errors
      expected = {'--this-option-is-not-valid' => 'is not a valid option'}
      assert_equal expected, @args.errors
    end
    
    def test_should_return_empty_hash_when_sent_options
      assert_equal({}, @args.options)
    end
    
    def test_should_return_false_when_sent_validQUESTION
      assert_equal false, @args.valid?
    end
    
  end
  
  class WithShortOptionArgAndWithoutValidOptions < Test::Unit::TestCase
    
    def setup
      arg = '-this-option-is-not-valid'
      @args = Trapeze::Command.new(:args => arg)
    end
    
    def test_should_return_array_containing_expected_args_when_sent_args
      assert_equal ['-this-option-is-not-valid'], @args.args
    end
    
    def test_should_return_hash_containing_expected_error_when_sent_errors
      expected = {'-this-option-is-not-valid' => 'is not a valid option'}
      assert_equal expected, @args.errors
    end
    
    def test_should_return_empty_hash_when_sent_options
      assert_equal({}, @args.options)
    end
    
    def test_should_return_false_when_sent_validQUESTION
      assert_equal false, @args.valid?
    end
    
  end
  
  class WithArgAndWithoutValidOptions < Test::Unit::TestCase
    
    def setup
      @args = Trapeze::Command.new(:args => 'this-arg-is-not-valid')
    end
    
    def test_should_return_array_containing_expected_args_when_sent_args
      assert_equal ['this-arg-is-not-valid'], @args.args
    end
    
    def test_should_return_hash_containing_expected_error_when_sent_errors
      expected = {'this-arg-is-not-valid' => 'is not a valid argument'}
      assert_equal expected, @args.errors
    end
    
    def test_should_return_empty_hash_when_sent_options
      assert_equal({}, @args.options)
    end
    
    def test_should_return_false_when_sent_validQUESTION
      assert_equal false, @args.valid?
    end
    
  end
  
  class WithNoArgsAndWithValidOption < Test::Unit::TestCase
    
    def setup
      valid_option = {'--foo-bar' => %w(-f bat)}
      @args = Trapeze::Command.new(:valid_options => valid_option)
    end
    
    def test_should_return_empty_array_when_sent_args
      assert_equal [], @args.args
    end
    
    def test_should_return_empty_hash_when_sent_errors
      assert_equal({}, @args.errors)
    end
    
    def test_should_return_hash_containing_default_option_when_sent_options
      assert_equal({:foo_bar => 'bat'}, @args.options)
    end
    
    def test_should_return_true_when_sent_validQUESTION
      assert_equal true, @args.valid?
    end
    
  end
  
  class WithNoArgsAndWithValidOptionLackingDefault < Test::Unit::TestCase
    
    def setup
      valid_option = {'--foo-bar' => '-f'}
      @args = Trapeze::Command.new(:valid_options => valid_option)
    end
    
    def test_should_return_empty_array_when_sent_args
      assert_equal [], @args.args
    end
    
    def test_should_return_empty_hash_when_sent_errors
      assert_equal({}, @args.errors)
    end
    
    def test_should_return_hash_containing_default_option_when_sent_options
      assert_equal({:foo_bar => nil}, @args.options)
    end
    
    def test_should_return_true_when_sent_validQUESTION
      assert_equal true, @args.valid?
    end
    
  end
  
  class WithLongOptionMatchingValidOption < Test::Unit::TestCase
    
    def setup
      valid_option = {'--foo-bar' => %w(-f bat)}
      @args = Trapeze::Command.new(:args => %w(--foo-bar baz),
                                   :valid_options => valid_option)
    end
    
    def test_should_return_array_containing_expected_args_when_sent_args
      assert_equal %w(--foo-bar baz), @args.args
    end
    
    def test_should_return_empty_hash_when_sent_errors
      assert_equal({}, @args.errors)
    end
    
    def test_should_return_hash_containing_expected_option_when_sent_options
      assert_equal({:foo_bar => 'baz'}, @args.options)
    end
    
    def test_should_return_true_when_sent_validQUESTION
      assert_equal true, @args.valid?
    end
    
  end
  
  class WithShortOptionMatchingValidOption < Test::Unit::TestCase
    
    def setup
      valid_option = {'--foo-bar' => %w(-f bat)}
      @args = Trapeze::Command.new(:args => %w(-f baz),
                                   :valid_options => valid_option)
    end
    
    def test_should_return_array_containing_expected_args_when_sent_args
      assert_equal %w(-f baz), @args.args
    end
    
    def test_should_return_empty_hash_when_sent_errors
      assert_equal({}, @args.errors)
    end
    
    def test_should_return_hash_containing_expected_option_when_sent_options
      assert_equal({:foo_bar => 'baz'}, @args.options)
    end
    
    def test_should_return_true_when_sent_validQUESTION
      assert_equal true, @args.valid?
    end
    
  end
  
end

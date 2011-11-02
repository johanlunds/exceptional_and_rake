require 'bundler/setup'
Bundler.require

# Needs Ruby 1.9
require 'minitest/autorun'

class ExceptionalAndRakeTest < MiniTest::Unit::TestCase
  
  def test_that_method_is_not_included_by_default
    assert_equal "", run_fixture(:defined_without_rake)
  end
  
  def test_that_method_is_included_when_rake_is_present
    assert_equal "method", run_fixture(:defined_with_rake)
  end
  
  private
  
    def run_fixture(name)
      `ruby #{File.dirname(__FILE__)}/fixtures/#{name}.rb 2>&1`.strip
    end
  
end

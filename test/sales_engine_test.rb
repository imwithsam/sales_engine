require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_engine_starts
    assert !!SalesEngine.new
  end
end




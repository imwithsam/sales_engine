require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_engine_starts
    assert !!SalesEngine.new
  end
  def test_engine_loads_merchant_repository
    engine = SalesEngine.new
    result = engine.startup
    assert true
  end



end



#has access to each of the repositories
#
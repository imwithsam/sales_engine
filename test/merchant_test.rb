require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_has_id
    merchant = Merchant.new

    assert 1, merchant.id
  end

  def test_reads_file
    merchant = Merchant.new
    merchant.read_file

    assert 1, 1
  end

end



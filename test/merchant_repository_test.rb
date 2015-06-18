require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_find_by_name
    merchant_name = "Willms and Sons"
    merch_repo = MerchantRepository.new('./data/test_data/merchants_test.csv')
    result = merch_repo.find_by_name(merchant_name)

    assert_equal merchant_name, result.name
  end

  def test_find_all_by_name
    merchant_name = "Willms and Sons"
    merch_repo = MerchantRepository.new('./data/test_data/merchants_test.csv', )
    result = merch_repo.find_all_by_name(merchant_name)

    assert_equal merchant_name, result[0].name
  end
end


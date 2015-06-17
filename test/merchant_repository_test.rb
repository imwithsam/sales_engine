require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test

  def test_returns_all_merchants
    merch_repo = MerchantRepository.new('./data/test_data/merchants_test.csv')
    result = merch_repo.all
    assert_equal 3, result.count
    assert_equal 1, result.first.id
    assert_equal "Schroeder-Jerde", result.first.name
    assert_equal "2012-03-27 14:53:59 UTC", result.first.created_at
    assert_equal "2012-03-27 14:53:59 UTC", result.first.updated_at
    assert_equal 2, result[1].id
    assert_equal "Klein, Rempel and Jones", result[1].name
    assert_equal "2012-03-27 14:53:59 UTC", result[1].created_at
    assert_equal "2012-03-27 14:53:59 UTC", result[1].updated_at
    assert_equal 3, result[2].id
    assert_equal "Willms and Sons", result[2].name
    assert_equal "2012-03-27 14:53:59 UTC", result[2].created_at
    assert_equal "2012-03-27 14:53:59 UTC", result[2].updated_at
  end


end
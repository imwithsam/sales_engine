require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class RepositoryTest < Minitest::Test
  def test_returns_all_merchants
    merch_repo = MerchantRepository.new('./data/test_data/merchants_test.csv')
    result = merch_repo.all
    assert_equal 3, result.count
    assert_equal 1, result[0].id
    assert_equal "Schroeder-Jerde", result[0].name
    assert_equal "2012-03-27 14:53:59 UTC", result[0].created_at
    assert_equal "2012-04-29 12:22:12 UTC", result[0].updated_at
    assert_equal 2, result[1].id
    assert_equal "Klein, Rempel and Jones", result[1].name
    assert_equal "2014-02-04 10:21:16 UTC", result[1].created_at
    assert_equal "2014-02-05 18:01:32 UTC", result[1].updated_at
    assert_equal 3, result[2].id
    assert_equal "Willms and Sons", result[2].name
    assert_equal "2014-02-04 10:21:16 UTC", result[2].created_at
    assert_equal "2014-02-05 18:01:32 UTC", result[2].updated_at
  end

  def test_returns_random_merchant
    merch_repo = MerchantRepository.new('./data/test_data/merchants_test.csv')
    assertion = false

    10.times do
      if merch_repo.random.id == 1
        assertion = true
      end
    end

    assert assertion, "Random ID did not match in 10 tries."
  end

  def test_find_merchant_by_id
    merchant_id = 2
    merch_repo = MerchantRepository.new('./data/test_data/merchants_test.csv')
    result = merch_repo.find_by_id(merchant_id)

    assert_equal 2, result.id
    assert_equal "Klein, Rempel and Jones", result.name
    assert_equal "2014-02-04 10:21:16 UTC", result.created_at
    assert_equal "2014-02-05 18:01:32 UTC", result.updated_at
  end

  def test_find_merchant_by_created_at
    merchant_created_at = "2012-03-27 14:53:59 UTC"
    merch_repo = MerchantRepository.new('./data/test_data/merchants_test.csv')
    result = merch_repo.find_by_created_at(merchant_created_at)

    assert_equal merchant_created_at, result.created_at
  end

  def test_find_merchant_by_updated_at
    merchant_updated_at = "2012-04-29 12:22:12 UTC"
    merch_repo = MerchantRepository.new('./data/test_data/merchants_test.csv')
    result = merch_repo.find_by_updated_at(merchant_updated_at)

    assert_equal merchant_updated_at, result.updated_at
  end

  def test_find_all_merchants_by_id
    merchant_id = 2
    merch_repo = MerchantRepository.new('./data/test_data/merchants_test.csv')
    result = merch_repo.find_all_by_id(merchant_id)

    assert_equal merchant_id, result[0].id
    assert_equal "Klein, Rempel and Jones", result[0].name
    assert_equal "2014-02-04 10:21:16 UTC", result[0].created_at
    assert_equal "2014-02-05 18:01:32 UTC", result[0].updated_at
  end

  def test_find_all_merchants_by_created_at
    merchant_created_at = "2014-02-04 10:21:16 UTC"
    merch_repo = MerchantRepository.new('./data/test_data/merchants_test.csv')
    result = merch_repo.find_all_by_created_at(merchant_created_at)

    assert_equal merchant_created_at, result[0].created_at
    assert_equal merchant_created_at, result[1].created_at
  end

  def test_find_all_merchants_by_updated_at
    merchant_updated_at = "2014-02-05 18:01:32 UTC"
    merch_repo = MerchantRepository.new('./data/test_data/merchants_test.csv')
    result = merch_repo.find_all_by_updated_at(merchant_updated_at)

    assert_equal merchant_updated_at, result[0].updated_at
    assert_equal merchant_updated_at, result[1].updated_at
  end
end

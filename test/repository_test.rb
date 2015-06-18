require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class RepositoryTest < Minitest::Test
  def test_returns_all_merchants
    sales_engine = SalesEngine.new
    merch_repo = MerchantRepository.new(
      [{ id: 1 }, { id: 2 }, { id: 3 }],
      sales_engine)
    merchants = merch_repo.all

    assert_equal [1, 2, 3], merchants.map { |merchant| merchant.id }
  end

  def test_returns_random_merchant
    sales_engine = SalesEngine.new
    merch_repo = MerchantRepository.new(
      [{ id: 1 }, { id: 2 }, { id: 3 }],
      sales_engine)
    random_match = false

    10.times do
      random_match = true if merch_repo.random.id == 2
    end

    assert random_match, "Random ID did not match in 10 tries."
  end

  def test_find_merchant_by_id
    merchant_id = 2
    sales_engine = SalesEngine.new
    merch_repo = MerchantRepository.new(
      [{ id: 1 }, { id: 2 }, { id: 3 }],
      sales_engine)
    merchant = merch_repo.find_by_id(merchant_id)

    assert_equal 2, merchant.id
  end

  def test_find_merchant_by_created_at
    merchant_created_at = "2014-02-04 10:21:16 UTC"
    sales_engine = SalesEngine.new
    merch_repo = MerchantRepository.new([
      { id: 1, created_at: "2014-07-14 11:01:15 UTC" },
      { id: 2, created_at: "2014-02-04 10:21:16 UTC" },
      { id: 3, created_at: "2015-06-18 11:20:44 UTC" }],
      sales_engine)
    merchant = merch_repo.find_by_created_at(merchant_created_at)

    assert_equal 2, merchant.id
  end

  def test_find_merchant_by_updated_at
    merchant_updated_at = "2014-02-05 18:01:32 UTC"
    sales_engine = SalesEngine.new
    merch_repo = MerchantRepository.new([
      { id: 1, updated_at: "2014-09-12 04:45:00 UTC" },
      { id: 2, updated_at: "2014-02-05 18:01:32 UTC" },
      { id: 3, updated_at: "2015-06-18 10:11:11 UTC" }],
      sales_engine)
    merchant = merch_repo.find_by_updated_at(merchant_updated_at)

    assert_equal 2, merchant.id
  end

  def test_find_all_merchants_by_id
    merchant_id = 2
    sales_engine = SalesEngine.new
    merch_repo = MerchantRepository.new(
        [{ id: 1 }, { id: 2 }, { id: 2 }, { id: 3 }],
        sales_engine)
    merchants = merch_repo.find_all_by_id(merchant_id)

    assert_equal [2, 2], merchants.map { |merchant| merchant.id }
  end

  def test_find_all_merchants_by_created_at
    merchant_created_at = "2014-02-04 10:21:16 UTC"
    sales_engine = SalesEngine.new
    merch_repo = MerchantRepository.new([
      { id: 1, created_at: "2014-07-14 11:01:15 UTC" },
      { id: 2, created_at: "2014-02-04 10:21:16 UTC" },
      { id: 3, created_at: "2015-06-18 11:20:44 UTC" },
      { id: 4, created_at: "2014-02-04 10:21:16 UTC" }],
      sales_engine)
    merchants = merch_repo.find_all_by_created_at(merchant_created_at)

    assert_equal [2, 4], merchants.map { |merchant| merchant.id }
  end

  def test_find_all_merchants_by_updated_at
    merchant_updated_at = "2014-02-05 18:01:32 UTC"
    sales_engine = SalesEngine.new
    merch_repo = MerchantRepository.new([
      { id: 1, updated_at: "2014-09-12 04:45:00 UTC" },
      { id: 2, updated_at: "2014-02-05 18:01:32 UTC" },
      { id: 3, updated_at: "2015-06-18 10:11:11 UTC" },
      { id: 4, updated_at: "2014-02-05 18:01:32 UTC" }],
      sales_engine)
    merchants = merch_repo.find_all_by_updated_at(merchant_updated_at)

    assert_equal [2, 4], merchants.map { |merchant| merchant.id }
  end
end

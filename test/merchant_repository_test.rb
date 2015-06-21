require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_find_by_name
    sales_engine = SalesEngine.new
    merchant_repo = MerchantRepository.new(
      [{ id: 1, name: "Willms and Sons" },
      { id: 2, name: "Bingo Brothers" },
      { id: 3, name: "Super Duper Deluxe Plus" }],
      sales_engine)
    merchant = merchant_repo.find_by_name("Bingo Brothers")

    assert_equal 2, merchant.id
  end

  def test_find_all_by_name
    sales_engine = SalesEngine.new
    merchant_repo = MerchantRepository.new(
      [{ id: 1, name: "Willms and Sons" },
      { id: 2, name: "Bingo Brothers" },
      { id: 3, name: "Super Duper Deluxe Plus"},
      { id: 4, name: "Bingo Brothers" }],
      sales_engine)
    merchants = merchant_repo.find_all_by_name("Bingo Brothers")

    assert_equal [2, 4],
                 merchants.map { |merchant| merchant.id }
  end
end


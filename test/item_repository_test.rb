require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_find_by_name
    sales_engine = SalesEngine.new
    item_repo = ItemRepository.new(
        [{ id: 10, name: "Item Bacon" },
         { id: 20, name: "Item Pogo Stick" },
         { id: 30, name: "Item Rice" }],
        sales_engine)
    item = item_repo.find_by_name("Item Pogo Stick")

    assert_equal 20, item.id
  end

  def test_find_by_description
    sales_engine = SalesEngine.new
    item_repo = ItemRepository.new(
        [{ id: 10, description: "magical meat" },
         { id: 20, description: "old school fun" },
         { id: 30, description: "staple food of the East" }],
        sales_engine)
    item = item_repo.find_by_description("old school fun")

    assert_equal 20, item.id
  end

  def test_find_by_unit_price
    sales_engine = SalesEngine.new
    item_repo = ItemRepository.new(
        [{ id: 10, unit_price: "4242" },
         { id: 20, unit_price: "47162" },
         { id: 30, unit_price: "9812" }],
        sales_engine)
    item = item_repo.find_by_unit_price("47162")

    assert_equal 20, item.id
  end

  def test_find_by_merchant_id
    sales_engine = SalesEngine.new
    item_repo = ItemRepository.new(
        [{ id: 10, merchant_id: 1 },
         { id: 20, merchant_id: 2 },
         { id: 30, merchant_id: 3 }],
        sales_engine)
    item = item_repo.find_by_merchant_id(2)

    assert_equal 20, item.id
  end
end


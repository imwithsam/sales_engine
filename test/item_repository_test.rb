require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
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
    item = item_repo.find_by_unit_price(BigDecimal.new("47162") / 100)

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

  def test_find_all_by_name
    sales_engine = SalesEngine.new
    item_repo = ItemRepository.new(
      [{ id: 10, name: "Item Bacon" },
       { id: 20, name: "Item Pogo Stick" },
       { id: 30, name: "Item Rice" },
       { id: 40, name: "Item Pogo Stick" }],
      sales_engine)
    items = item_repo.find_all_by_name("Item Pogo Stick")

    assert_equal [20, 40], items.map { |item| item.id }
  end

  def test_find_by_description
    sales_engine = SalesEngine.new
    item_repo = ItemRepository.new(
      [{ id: 10, description: "magical meat" },
       { id: 20, description: "old school fun" },
       { id: 30, description: "staple food of the East" },
       { id: 40, description: "old school fun" }],
      sales_engine)
    items = item_repo.find_all_by_description("old school fun")

    assert_equal [20, 40], items.map { |item| item.id }
  end

  def test_find_by_unit_price
    sales_engine = SalesEngine.new
    item_repo = ItemRepository.new(
      [{ id: 10, unit_price: "4242" },
       { id: 20, unit_price: "47162" },
       { id: 30, unit_price: "9812" },
       { id: 40, unit_price: "47162" }],
      sales_engine)
    items = item_repo.find_all_by_unit_price(BigDecimal.new("47162") / 100)

    assert_equal [20, 40], items.map { |item| item.id }
  end

  def test_find_by_merchant_id
    sales_engine = SalesEngine.new
    item_repo = ItemRepository.new(
      [{ id: 10, merchant_id: 1 },
       { id: 20, merchant_id: 2 },
       { id: 30, merchant_id: 3 },
       { id: 40, merchant_id: 2 }],
      sales_engine)
    items = item_repo.find_all_by_merchant_id(2)

    assert_equal [20, 40], items.map { |item| item.id }
  end

  def test_most_revenue
    sales_engine = SalesEngine.new
    item_repo = ItemRepository.new(
        [{ id: 1 },
         { id: 2 },
         { id: 3 }],
        sales_engine)
    sales_engine.invoice_repository = InvoiceRepository.new(
        [{ id: 1000 },
         { id: 2000 },
         { id: 3000 },
         { id: 4000 }],
        sales_engine)
    sales_engine.invoice_item_repository = InvoiceItemRepository.new(
        [{ id: 10, item_id: 1, invoice_id: 1000, quantity: 2, unit_price: "100" },
         { id: 20, item_id: 2, invoice_id: 2000, quantity: 3, unit_price: "170" },
         { id: 30, item_id: 2, invoice_id: 3000, quantity: 1, unit_price: "120" },
         { id: 40, item_id: 3, invoice_id: 4000, quantity: 4, unit_price: "110" }],
        sales_engine)
    sales_engine.transaction_repository = TransactionRepository.new(
        [{ id: 100, invoice_id: 1000, result: "success" },
         { id: 200, invoice_id: 2000, result: "success" },
         { id: 300, invoice_id: 3000, result: "failed" },
         { id: 400, invoice_id: 4000, result: "success" }],
        sales_engine)

    # 1: 2 * 100 = 200
    # 2: 3 * 170 = 510
    # 3: 4 * 110 = 440
    assert_equal [2, 3], item_repo.most_revenue(2).map(&:id)
  end
end


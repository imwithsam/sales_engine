require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/item'

class ItemTest < MiniTest::Test
  def test_invoice_items_returned_for_item_instance
    sales_engine = SalesEngine.new
    sales_engine.invoice_item_repository = InvoiceItemRepository.new(
        [{ id: 10, item_id: 1 },
         { id: 20, item_id: 2 },
         { id: 30, item_id: 2 }],
        sales_engine)
    item_repo = ItemRepository.new(
        [{ id: 1 },
         { id: 2 }],
        sales_engine)
    item = item_repo.find_by_id(2)

    assert_equal [20, 30], item.invoice_items.map { |item| item.id }
  end

  def test_merchant_returned_for_item_instance
    sales_engine = SalesEngine.new
    sales_engine.merchant_repository = MerchantRepository.new(
        [{ id: 10, item_id: 1 },
         { id: 20, item_id: 2 },
         { id: 20, item_id: 2 }],
        sales_engine)
    item_repo = ItemRepository.new(
        [{ id: 1, merchant_id: 10 },
         { id: 2, merchant_id: 20 }],
        sales_engine)
    item = item_repo.find_by_id(2)

    assert_equal 20, item.merchant.id
  end

  def test_best_day
    sales_engine = SalesEngine.new
    item_repo = ItemRepository.new([{ id: 1 }], sales_engine)
    sales_engine.invoice_repository = InvoiceRepository.new(
        [{ id: 10, created_at: "2012-03-21 09:54:09 UTC" },
         { id: 20, created_at: "2012-03-22 09:54:09 UTC" },
         { id: 30, created_at: "2012-03-23 09:54:09 UTC" },
         { id: 40, created_at: "2012-03-24 09:54:09 UTC" }],
        sales_engine)
    sales_engine.invoice_item_repository = InvoiceItemRepository.new(
        [{ id: 100, invoice_id: 10, item_id: 1, quantity: 1, unit_price: "100" },
         { id: 200, invoice_id: 20, item_id: 1, quantity: 2, unit_price: "100" },
         { id: 300, invoice_id: 30, item_id: 1, quantity: 3, unit_price: "100" },
         { id: 400, invoice_id: 40, item_id: 1, quantity: 4, unit_price: "100" },],
        sales_engine)
    sales_engine.transaction_repository = TransactionRepository.new(
        [{ id: 1000, invoice_id: 10, result: "success" },
         { id: 2000, invoice_id: 20, result: "success" },
         { id: 3000, invoice_id: 30, result: "success" },
         { id: 4000, invoice_id: 40, result: "failed" }],
        sales_engine)
    item = item_repo.find_by_id(1)

    assert_equal Date.parse("2012-03-23"), item.best_day
  end
end


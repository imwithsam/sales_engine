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
end


require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant'

class MerchantTest < MiniTest::Test
  def test_items_returned_for_merchant_instance
    sales_engine = SalesEngine.new
    sales_engine.item_repository = ItemRepository.new(
      [{ id: 10, merchant_id: 1 },
       { id: 20, merchant_id: 2 },
       { id: 30, merchant_id: 2 }],
      sales_engine)
    merchant_repo = MerchantRepository.new(
      [{ id: 1, name: "Willms and Sons"},
       { id: 2, name: "Bingo Brothers"}],
      sales_engine)
    merchant = merchant_repo.find_by_id(2)

    assert_equal [20, 30], merchant.items.map { |item| item.id }
  end

  def test_invoices_returned_for_merchant_instance
    sales_engine = SalesEngine.new
    sales_engine.invoice_repository = InvoiceRepository.new(
        [{ id: 10, merchant_id: 1 },
         { id: 20, merchant_id: 2 },
         { id: 30, merchant_id: 2 }],
        sales_engine)
    merchant_repo = MerchantRepository.new(
        [{ id: 1, name: "Willms and Sons"},
         { id: 2, name: "Bingo Brothers"}],
        sales_engine)
    merchant = merchant_repo.find_by_id(2)

    assert_equal [20, 30], merchant.invoices.map { |invoice| invoice.id }
  end
end


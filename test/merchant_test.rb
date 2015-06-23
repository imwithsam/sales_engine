require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
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

  def test_returns_total_revenue_for_all_transactions
    sales_engine = SalesEngine.new
    sales_engine.invoice_repository = InvoiceRepository.new(
        [{ id: 10, merchant_id: 1 },
         { id: 20, merchant_id: 1 }],
        sales_engine)
    sales_engine.transaction_repository = TransactionRepository.new(
        [{ id:  100, invoice_id:  10, result: "failed" },
         { id:  200, invoice_id:  10, result: "success" },
         { id:  300, invoice_id:  20, result: "failed" }],
        sales_engine)
   sales_engine.invoice_item_repository = InvoiceItemRepository.new(
         [{ id:  1000, invoice_id:  10, quantity: 2, unit_price: "100" },
          { id:  2000, invoice_id:  10, quantity: 3, unit_price: "1000" },
          { id:  3000, invoice_id:  20, quantity: 1, unit_price: "200" }],
         sales_engine)
    merchant_repo = MerchantRepository.new([{ id: 1 }], sales_engine)
    merchant = merchant_repo.find_by_id(1)

    assert_equal (BigDecimal.new("3200") / 100), merchant.revenue
  end
end


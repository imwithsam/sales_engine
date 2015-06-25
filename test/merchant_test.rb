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

  def test_returns_total_revenue_by_invoice_date
    sales_engine = SalesEngine.new
    sales_engine.invoice_repository = InvoiceRepository.new(
        [{ id: 10, merchant_id: 1, created_at: "2012-03-25 09:54:09 UTC" },
         { id: 20, merchant_id: 1, created_at: "2012-03-26 09:54:09 UTC" },
         { id: 30, merchant_id: 1, created_at: "2012-03-25 09:54:09 UTC" },
         { id: 40, merchant_id: 1, created_at: "2012-03-25 09:54:09 UTC" }],
        sales_engine)
    sales_engine.transaction_repository = TransactionRepository.new(
        [{ id:  100, invoice_id:  10, result: "success" },
         { id:  200, invoice_id:  20, result: "success" },
         { id:  300, invoice_id:  30, result: "success" },
         { id:  300, invoice_id:  40, result: "failed" }],
        sales_engine)
    sales_engine.invoice_item_repository = InvoiceItemRepository.new(
        [{ id:  1000, invoice_id:  10, quantity: 2, unit_price: "100" },
         { id:  2000, invoice_id:  10, quantity: 3, unit_price: "1000" },
         { id:  3000, invoice_id:  20, quantity: 1, unit_price: "200" },
         { id:  4000, invoice_id:  30, quantity: 3, unit_price: "90" },
         { id:  5000, invoice_id:  30, quantity: 3, unit_price: "35" },
         { id:  6000, invoice_id:  40, quantity: 3, unit_price: "75" }],
        sales_engine)
    merchant_repo = MerchantRepository.new([{ id: 1 }], sales_engine)
    merchant = merchant_repo.find_by_id(1)

    date = Date.parse("2012-03-25")

    # 10 & 30: 2 * 100 + 3 * 1000 + 3 * 90 + 3 * 35 = 3575
    assert_equal (BigDecimal.new("3575") / 100), merchant.revenue(date)
  end

  def test_returns_customers_with_pending_invoices
    sales_engine = SalesEngine.new
    sales_engine.invoice_repository = InvoiceRepository.new(
        [{ id: 10, merchant_id: 1, customer_id: 1000 },
         { id: 20, merchant_id: 1, customer_id: 2000 },
         { id: 30, merchant_id: 1, customer_id: 2000 },
         { id: 40, merchant_id: 1, customer_id: 3000 },
         { id: 50, merchant_id: 1, customer_id: 3000 },
         { id: 60, merchant_id: 1, customer_id: 3000 }],
        sales_engine)
    sales_engine.transaction_repository = TransactionRepository.new(
        [{ id:  100, invoice_id:  10, result: "success" },
         { id:  200, invoice_id:  20, result: "failed" },
         { id:  300, invoice_id:  30, result: "success" },
         { id:  400, invoice_id:  40, result: "failed" },
         { id:  500, invoice_id:  50, result: "failed" },
         { id:  600, invoice_id:  60, result: "success" }],
        sales_engine)
    sales_engine.customer_repository = CustomerRepository.new(
        [{ id:  1000 },
         { id:  2000 },
         { id:  3000 }],
        sales_engine)
    merchant_repo = MerchantRepository.new([{ id: 1 }], sales_engine)
    merchant = merchant_repo.find_by_id(1)

    assert_equal [2000, 3000], merchant.customers_with_pending_invoices.map(&:id)
  end
end


require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/customer'

class CustomerTest < MiniTest::Test
  def test_invoices_returned_for_customer_instance
    sales_engine = SalesEngine.new
    sales_engine.invoice_repository = InvoiceRepository.new(
        [{ id: 10, customer_id: 1 },
         { id: 20, customer_id: 2 },
         { id: 30, customer_id: 3 },
         { id: 40, customer_id: 2 }],
        sales_engine)
    customer_repo = CustomerRepository.new(
        [{ id: 1 },
         { id: 2 },
         { id: 3 }],
        sales_engine)
    customer = customer_repo.find_by_id(2)

    assert_equal [20, 40], customer.invoices.map { |invoice| invoice.id }
  end

  def test_transactions_returned_for_customer_instance
    sales_engine = SalesEngine.new
    sales_engine.invoice_repository = InvoiceRepository.new(
        [{ id: 10, customer_id: 1 },
         { id: 20, customer_id: 2 },
         { id: 30, customer_id: 3 },
         { id: 40, customer_id: 2 }],
        sales_engine)
    sales_engine.transaction_repository = TransactionRepository.new(
        [{id: 100, invoice_id: 10 },
         {id: 200, invoice_id: 20 },
         {id: 300, invoice_id: 20 },
         {id: 400, invoice_id: 30 },
         {id: 500, invoice_id: 40 },],
        sales_engine)
    customer_repo = CustomerRepository.new(
        [{ id: 1 },
         { id: 2 },
         { id: 3 }],
        sales_engine)
    customer = customer_repo.find_by_id(2)

    assert_equal [200, 300, 500], customer.transactions.map { |transaction| transaction.id }
  end

  def test_favorite_merchant
    sales_engine = SalesEngine.new
    customer_repo = CustomerRepository.new([{ id: 1 }], sales_engine)
    sales_engine.merchant_repository = MerchantRepository.new(
        [{ id: 100 },
         { id: 200 },
         { id: 300 },
         { id: 400 }],
        sales_engine)
    sales_engine.invoice_repository = InvoiceRepository.new(
        [{ id: 10, customer_id: 1, merchant_id: 100 },
         { id: 20, customer_id: 1, merchant_id: 200 },
         { id: 30, customer_id: 1, merchant_id: 200 },
         { id: 40, customer_id: 1, merchant_id: 300 },
         { id: 50, customer_id: 1, merchant_id: 300 },
         { id: 60, customer_id: 1, merchant_id: 300 },
         { id: 70, customer_id: 1, merchant_id: 400 },
         { id: 80, customer_id: 1, merchant_id: 400 }],
        sales_engine)
    sales_engine.transaction_repository = TransactionRepository.new(
        [{ id: 1000, invoice_id: 10, result: "success" },
         { id: 2000, invoice_id: 20, result: "success" },
         { id: 3000, invoice_id: 30, result: "success" },
         { id: 4000, invoice_id: 40, result: "failed" },
         { id: 5000, invoice_id: 50, result: "failed" },
         { id: 6000, invoice_id: 60, result: "success" },
         { id: 7000, invoice_id: 70, result: "success" },
         { id: 8000, invoice_id: 80, result: "failed" }],
        sales_engine)
    customer = customer_repo.find_by_id(1)

    assert_equal 200, customer.favorite_merchant.id
  end
end


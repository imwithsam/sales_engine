require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice'

class InvoiceTest < MiniTest::Test
  def test_transactions_returned_for_invoice_instance
    sales_engine = SalesEngine.new
    sales_engine.transaction_repository = TransactionRepository.new(
        [{ id: 10, invoice_id: 1 },
         { id: 20, invoice_id: 2 },
         { id: 30, invoice_id: 2 }],
        sales_engine)
    invoice_repo = InvoiceRepository.new(
        [{ id: 1 },
         { id: 2 }],
        sales_engine)
    invoice = invoice_repo.find_by_id(2)

    assert_equal [20, 30], invoice.transactions.map { |invoice| invoice.id }
  end

  def test_invoice_items_returned_for_invoice_instance
    sales_engine = SalesEngine.new
    sales_engine.invoice_item_repository = InvoiceItemRepository.new(
        [{ id: 10, invoice_id: 1 },
         { id: 20, invoice_id: 2 },
         { id: 30, invoice_id: 2 }],
        sales_engine)
    invoice_repo = InvoiceRepository.new(
        [{ id: 1 },
         { id: 2 }],
        sales_engine)
    invoice = invoice_repo.find_by_id(2)

    assert_equal [20, 30], invoice.invoice_items.map { |item| item.id }
  end


  def test_items_returned_for_invoice_instance
    sales_engine = SalesEngine.new
    sales_engine.item_repository = ItemRepository.new(
        [{ id: 10 },
         { id: 20 },
         { id: 30 }],
        sales_engine)
    sales_engine.invoice_item_repository = InvoiceItemRepository.new(
        [{ id: 100, invoice_id: 1, item_id: 10 },
         { id: 200, invoice_id: 2, item_id: 20 },
         { id: 300, invoice_id: 2, item_id: 30 }],
        sales_engine)
    invoice_repo = InvoiceRepository.new(
        [{ id: 1 },
         { id: 2 }],
        sales_engine)
    invoice = invoice_repo.find_by_id(2)

    assert_equal [20, 30], invoice.items.map { |item| item.id }
  end

  def test_customer_returned_for_invoice_instance
    sales_engine = SalesEngine.new
    sales_engine.customer_repository = CustomerRepository.new(
        [{ id: 10, invoice_id: 1 },
         { id: 20, invoice_id: 2 },
         { id: 20, invoice_id: 2 }],
        sales_engine)
    invoice_repo = InvoiceRepository.new(
        [{ id: 1, customer_id: 10 },
         { id: 2, customer_id: 20 }],
        sales_engine)
    invoice = invoice_repo.find_by_id(2)

    assert_equal 20, invoice.customer.id
  end

  def test_merchant_returned_for_invoice_instance
    sales_engine = SalesEngine.new
    sales_engine.merchant_repository = MerchantRepository.new(
        [{ id: 10, invoice_id: 1 },
         { id: 20, invoice_id: 2 },
         { id: 20, invoice_id: 2 }],
        sales_engine)
    invoice_repo = InvoiceRepository.new(
        [{ id: 1, merchant_id: 10 },
         { id: 2, merchant_id: 20 }],
        sales_engine)
    invoice = invoice_repo.find_by_id(2)

    assert_equal 20, invoice.merchant.id
  end
end

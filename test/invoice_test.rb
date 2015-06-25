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

  def test_charge
    # Call invoice.charge
    # Inputs: cc_number, exp_date, result
    # Basically create a Transaction row
    # Need:
    #  transaction_id
    #  invoice_id
    #  credit_card_number
    #  credit_card_expiration_date
    #  result
    #  created_at
    #  updated_at
    sales_engine = SalesEngine.new
    sales_engine.invoice_repository = InvoiceRepository.new(
        [{ id: 1 }],
        sales_engine)
    sales_engine.transaction_repository = TransactionRepository.new(
        [{ id: 10 }],
        sales_engine
    )
    invoice = sales_engine.invoice_repository
              .find_by_id(1)
    attributes = {
      invoice_id: invoice.id,
      credit_card_number: "1234123412341234",
      credit_card_expiration_date: "12/17",
      result: "success"
    }
    invoice.charge(attributes)
    transaction = sales_engine.transaction_repository.find_by_id(11)

    assert_equal invoice.id,
      transaction.invoice_id
    assert_equal "1234123412341234",
      transaction.credit_card_number
    assert_equal "12/17",
      transaction.credit_card_expiration_date
    assert_equal "success",
      transaction.result
    assert_equal Date.today,
      transaction.created_at
    assert_equal Date.today,
      transaction.updated_at
  end
end

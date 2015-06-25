require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def test_find_by_customer_id
    sales_engine = SalesEngine.new
    invoice_repo = InvoiceRepository.new(
        [{ id: 10, customer_id: 1 },
         { id: 20, customer_id: 2 },
         { id: 30, customer_id: 3 }],
        sales_engine)
    invoice = invoice_repo.find_by_customer_id(2)

    assert_equal 20, invoice.id
  end

  def test_find_by_merchant_id
    sales_engine = SalesEngine.new
    invoice_repo = InvoiceRepository.new(
        [{ id: 10, merchant_id: 1 },
         { id: 20, merchant_id: 2 },
         { id: 30, merchant_id: 3 }],
        sales_engine)
    invoice = invoice_repo.find_by_merchant_id(2)

    assert_equal 20, invoice.id
  end

  def test_find_by_status
    sales_engine = SalesEngine.new
    invoice_repo = InvoiceRepository.new(
        [{ id: 10, status: "shipped" },
         { id: 20, status: "pending" },
         { id: 30, status: "shipped" }],
        sales_engine)
    invoice = invoice_repo.find_by_status("pending")

    assert_equal 20, invoice.id
  end

  def test_find_all_by_customer_id
    sales_engine = SalesEngine.new
    invoice_repo = InvoiceRepository.new(
        [{ id: 10, customer_id: 1 },
         { id: 20, customer_id: 2 },
         { id: 30, customer_id: 3 },
         { id: 40, customer_id: 2 }],
        sales_engine)
    invoices = invoice_repo.find_all_by_customer_id(2)

    assert_equal [20, 40], invoices.map { |invoice| invoice.id }
  end

  def test_find_all_by_merchant_id
    sales_engine = SalesEngine.new
    invoice_repo = InvoiceRepository.new(
        [{ id: 10, merchant_id: 1 },
         { id: 20, merchant_id: 2 },
         { id: 30, merchant_id: 3 },
         { id: 40, merchant_id: 2 }],
        sales_engine)
    invoices = invoice_repo.find_all_by_merchant_id(2)

    assert_equal [20, 40], invoices.map { |invoice| invoice.id }
  end

  def test_all_find_by_status
    sales_engine = SalesEngine.new
    invoice_repo = InvoiceRepository.new(
        [{ id: 10, status: "shipped" },
         { id: 20, status: "pending" },
         { id: 30, status: "shipped" },
         { id: 40, status: "pending" }],
        sales_engine)
    invoices = invoice_repo.find_all_by_status("pending")

    assert_equal [20, 40], invoices.map { |invoice| invoice.id }
  end

  def test_create_invoice
    skip
    sales_engine = SalesEngine.new
    sales_engine.customer_repository = CustomerRepository.new([{ id: 1 }], sales_engine)
    sales_engine.merchant_repository = MerchantRepository.new([{ id: 10 }], sales_engine)
    sales_engine.item_repository = ItemRepository.new(
       [{ id: 100, unit_price: "100" },
        { id: 200, unit_price: "200" }],
       sales_engine)
    sales_engine.invoice_repository = InvoiceRepository.new([{ id: 1000 }], sales_engine)
    sales_engine.invoice_item_repository = InvoiceItemRepository.new([{ id: 10000 }], sales_engine)
    sales_engine.transaction_repository = TransactionRepository.new(
       [{ id: 100000, result: "success" }],
       sales_engine
    )
    customer = sales_engine.customer_repository.find_by_id(1)
    merchant = sales_engine.merchant_repository.find_by_id(10)
    item_1 = sales_engine.item_repository.find_by_id(100)
    item_2 = sales_engine.item_repository.find_by_id(200)

    # customer: customer, merchant: merchant, status: "shipped",
    # items: [item1, item2, item3]
    sales_engine.invoice_repository.create({
        customer: customer,
        merchant: merchant,
        status: "shipped",
        items: [item_1, item_2, item_2]
    })

    invoice = sales_engine.invoice_repository.find_by_id(1000)
# TODO: Figure out why invoice.items is not returning anything
    assert_equal [100, 200], invoice.items.map(&:id)
    assert_equal 1001, invoice.items[-2].id
    assert_equal 2, invoice.items[-1].quantity
  end
end


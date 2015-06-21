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
end


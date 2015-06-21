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
end


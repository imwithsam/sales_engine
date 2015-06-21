require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction'

class TransactionTest < MiniTest::Test
  def test_invoice_returned_for_transaction_instance
    sales_engine = SalesEngine.new
    sales_engine.invoice_repository = InvoiceRepository.new(
        [{ id: 10 },
         { id: 20 },
         { id: 30 }],
        sales_engine)
    transaction_repo = TransactionRepository.new(
        [{ id: 1, invoice_id: 10 },
         { id: 2, invoice_id: 20 },
         { id: 3, invoice_id: 30 }],
        sales_engine)
    transaction = transaction_repo.find_by_id(2)

    assert_equal 20, transaction.invoice.id
  end
end


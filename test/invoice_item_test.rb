require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item'

class InvoiceItemTest < MiniTest::Test
  def test_invoice_returned_for_invoice_item_instance
    sales_engine = SalesEngine.new
    sales_engine.invoice_repository = InvoiceRepository.new(
        [{ id: 10 },
         { id: 20 },
         { id: 30 }],
        sales_engine)
    invoice_item_repo = InvoiceItemRepository.new(
        [{ id: 1, invoice_id: 10 },
         { id: 2, invoice_id: 20 },
         { id: 3, invoice_id: 30 }],
        sales_engine)
    invoice_item = invoice_item_repo.find_by_id(2)

    assert_equal 20, invoice_item.invoice.id
  end


  def test_item_returned_for_invoice_item_instance
    sales_engine = SalesEngine.new
    sales_engine.item_repository = ItemRepository.new(
        [{ id: 10 },
         { id: 20 },
         { id: 30 }],
        sales_engine)
    invoice_item_repo = InvoiceItemRepository.new(
        [{ id: 1, item_id: 10 },
         { id: 2, item_id: 20 },
         { id: 3, item_id: 30 }],
        sales_engine)
    invoice_item = invoice_item_repo.find_by_id(2)

    assert_equal 20, invoice_item.item.id
  end
end


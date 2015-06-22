require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def test_find_by_item_id
    sales_engine = SalesEngine.new
    invoice_item_repo = InvoiceItemRepository.new(
        [{ id: 10, item_id: 1 },
         { id: 20, item_id: 2 },
         { id: 30, item_id: 3 }],
        sales_engine)
    invoice_item = invoice_item_repo.find_by_item_id(2)

    assert_equal 20, invoice_item.id
  end

  def test_find_by_invoice_id
    sales_engine = SalesEngine.new
    invoice_item_repo = InvoiceItemRepository.new(
        [{ id: 10, invoice_id: 1 },
         { id: 20, invoice_id: 2 },
         { id: 30, invoice_id: 3 }],
        sales_engine)
    invoice_item = invoice_item_repo.find_by_invoice_id(2)

    assert_equal 20, invoice_item.id
  end

  def test_find_by_quantity
    sales_engine = SalesEngine.new
    invoice_item_repo = InvoiceItemRepository.new(
        [{ id: 10, quantity: 1 },
         { id: 20, quantity: 2 },
         { id: 30, quantity: 3 }],
        sales_engine)
    invoice_item = invoice_item_repo.find_by_quantity(2)

    assert_equal 20, invoice_item.id
  end

  def test_find_by_unit_price
    sales_engine = SalesEngine.new
    invoice_item_repo = InvoiceItemRepository.new(
        [{ id: 10, unit_price: "20095" },
         { id: 20, unit_price: "7550" },
         { id: 30, unit_price: "5995" }],
        sales_engine)
    invoice_item = invoice_item_repo.find_by_unit_price(BigDecimal.new("7550") / 100)

    assert_equal 20, invoice_item.id
  end

  def test_find_all_by_item_id
    sales_engine = SalesEngine.new
    invoice_item_repo = InvoiceItemRepository.new(
        [{ id: 10, item_id: 1 },
         { id: 20, item_id: 2 },
         { id: 30, item_id: 3 },
         { id: 40, item_id: 2 }],
        sales_engine)
    invoice_items = invoice_item_repo.find_all_by_item_id(2)

    assert_equal [20, 40], invoice_items.map { |invoice_item| invoice_item.id }
  end

  def test_find_all_by_invoice_id
    sales_engine = SalesEngine.new
    invoice_item_repo = InvoiceItemRepository.new(
        [{ id: 10, invoice_id: 1 },
         { id: 20, invoice_id: 2 },
         { id: 30, invoice_id: 3 },
         { id: 40, invoice_id: 2 }],
        sales_engine)
    invoice_items = invoice_item_repo.find_all_by_invoice_id(2)

    assert_equal [20, 40], invoice_items.map { |invoice_item| invoice_item.id }
  end

  def test_find_all_by_quantity
    sales_engine = SalesEngine.new
    invoice_item_repo = InvoiceItemRepository.new(
        [{ id: 10, quantity: 1 },
         { id: 20, quantity: 2 },
         { id: 30, quantity: 3 },
         { id: 40, quantity: 2 }],
        sales_engine)
    invoice_items = invoice_item_repo.find_all_by_quantity(2)

    assert_equal [20, 40], invoice_items.map { |invoice_item| invoice_item.id }
  end

  def test_find_by_unit_price
    sales_engine = SalesEngine.new
    invoice_item_repo = InvoiceItemRepository.new(
        [{ id: 10, unit_price: "20095" },
         { id: 20, unit_price: "7550" },
         { id: 30, unit_price: "5995" },
         { id: 40, unit_price: "7550" }],
        sales_engine)
    invoice_items = invoice_item_repo.find_all_by_unit_price(BigDecimal.new("7550") / 100)

    assert_equal [20, 40], invoice_items.map { |invoice_item| invoice_item.id }
  end
end


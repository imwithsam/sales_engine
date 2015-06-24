require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_find_by_name
    sales_engine = SalesEngine.new
    merchant_repo = MerchantRepository.new(
      [{ id: 1, name: "Willms and Sons" },
      { id: 2, name: "Bingo Brothers" },
      { id: 3, name: "Super Duper Deluxe Plus" }],
      sales_engine)
    merchant = merchant_repo.find_by_name("Bingo Brothers")

    assert_equal 2, merchant.id
  end

  def test_find_all_by_name
    sales_engine = SalesEngine.new
    merchant_repo = MerchantRepository.new(
      [{ id: 1, name: "Willms and Sons" },
      { id: 2, name: "Bingo Brothers" },
      { id: 3, name: "Super Duper Deluxe Plus"},
      { id: 4, name: "Bingo Brothers" }],
      sales_engine)
    merchants = merchant_repo.find_all_by_name("Bingo Brothers")

    assert_equal [2, 4],
                 merchants.map { |merchant| merchant.id }
  end

  def test_most_revenue
    sales_engine = SalesEngine.new
    merchant_repo = MerchantRepository.new(
        [{ id: 1 },
         { id: 2 },
         { id: 3 },
         { id: 4 },
         { id: 5 }],
        sales_engine)
    sales_engine.invoice_repository = InvoiceRepository.new(
      [{ id:  10, merchant_id: 1 },
       { id:  20, merchant_id: 2 },
       { id:  30, merchant_id: 2 },
       { id:  40, merchant_id: 3 },
       { id:  50, merchant_id: 3 },
       { id:  60, merchant_id: 4 },
       { id:  70, merchant_id: 4 },
       { id:  80, merchant_id: 5 },
       { id:  90, merchant_id: 5 },
       { id: 100, merchant_id: 5 }],
      sales_engine)
    sales_engine.transaction_repository = TransactionRepository.new(
        [{ id:  100, invoice_id:  10, result: "failed" },
         { id:  200, invoice_id:  10, result: "failed" },
         { id:  300, invoice_id:  20, result: "failed" },
         { id:  400, invoice_id:  20, result: "success" },
         { id:  500, invoice_id:  30, result: "success" },
         { id:  600, invoice_id:  40, result: "failed" },
         { id:  700, invoice_id:  40, result: "failed" },
         { id:  800, invoice_id:  40, result: "success" },
         { id:  900, invoice_id:  50, result: "failed" },
         { id: 1000, invoice_id:  50, result: "success" },
         { id: 1100, invoice_id:  60, result: "success" },
         { id: 1200, invoice_id:  70, result: "failed" },
         { id: 1300, invoice_id:  70, result: "success" },
         { id: 1400, invoice_id:  80, result: "failed" },
         { id: 1500, invoice_id:  80, result: "failed" },
         { id: 1600, invoice_id:  90, result: "success" },
         { id: 1700, invoice_id: 100, result: "failed" },
         { id: 1800, invoice_id: 100, result: "success" }],
        sales_engine)
    sales_engine.invoice_item_repository = InvoiceItemRepository.new(
        [{ id:  1000, invoice_id:  10, quantity: 2, unit_price: "2595" },
         { id:  2000, invoice_id:  20, quantity: 3, unit_price: "10015" },
         { id:  3000, invoice_id:  20, quantity: 1, unit_price: "2000" },
         { id:  4000, invoice_id:  30, quantity: 4, unit_price: "1550" },
         { id:  5000, invoice_id:  30, quantity: 5, unit_price: "14000" },
         { id:  6000, invoice_id:  30, quantity: 2, unit_price: "19999" },
         { id:  7000, invoice_id:  40, quantity: 4, unit_price: "82545" },
         { id:  8000, invoice_id:  40, quantity: 3, unit_price: "199" },
         { id:  9000, invoice_id:  50, quantity: 2, unit_price: "99" },
         { id: 10000, invoice_id:  50, quantity: 3, unit_price: "100000" },
         { id: 11000, invoice_id:  60, quantity: 2, unit_price: "19999" },
         { id: 12000, invoice_id:  70, quantity: 4, unit_price: "82545" },
         { id: 13000, invoice_id:  70, quantity: 3, unit_price: "500" },
         { id: 14000, invoice_id:  80, quantity: 2, unit_price: "125" },
         { id: 15000, invoice_id:  80, quantity: 3, unit_price: "20050" },
         { id: 16000, invoice_id:  80, quantity: 3, unit_price: "1035" },
         { id: 17000, invoice_id:  90, quantity: 3, unit_price: "18005" },
         { id: 18000, invoice_id:  90, quantity: 3, unit_price: "12199" },
         { id: 19000, invoice_id: 100, quantity: 3, unit_price: "6500" },
         { id: 20000, invoice_id: 100, quantity: 1, unit_price: "100" }],
        sales_engine)

    # 20, 30, 40, 50, 60, 70, 90, 100
    # (2) 20) 3 * 100.15 + 1 * 20 = 320.45
    # (2) 30) 4 * 15.50 + 5 * 140 + 2 * 199.99 = 1161.98
    # 2) 1482.43
    # (3) 40) 4 * 825.45 + 3 * 1.99 = 3307.77
    # (3) 50) 2 * .99 + 3 * 1000 = 3001.98
    # 3) 6309.75
    # (4) 60) 2 * 199.99 = 399.98
    # (4) 70) 4 * 825.45 + 3 * 5 = 3316.8
    # 4) 3716.78
    # (5) 90) 3 * 180.05 + 3 * 121.99 + = 906.12
    # (5) 100) 3 * 65 + 1 = 196
    # 5) 1102.12
    assert_equal [3, 4, 2], merchant_repo.most_revenue(3).map { |merchant| merchant.id }
  end

  def test_most_items
    sales_engine = SalesEngine.new
    merchant_repo = MerchantRepository.new(
        [{ id: 1 },
         { id: 2 },
         { id: 3 }],
        sales_engine)
    sales_engine.item_repository = ItemRepository.new(
        [{ id: 10, merchant_id: 1 },
         { id: 20, merchant_id: 2 },
         { id: 30, merchant_id: 2 },
         { id: 40, merchant_id: 3 },
         { id: 50, merchant_id: 3 },
         { id: 60, merchant_id: 3 },
         { id: 70, merchant_id: 1 },
         { id: 80, merchant_id: 1 }],
        sales_engine)
    sales_engine.invoice_repository = InvoiceRepository.new(
        [{ id:  10000, merchant_id: 1 },
         { id:  20000, merchant_id: 2 },
         { id:  30000, merchant_id: 2 },
         { id:  40000, merchant_id: 3 },
         { id:  50000, merchant_id: 3 }],
        sales_engine)
    sales_engine.transaction_repository = TransactionRepository.new(
        [{ id:  1000, invoice_id:  10000, result: "failed" },
         { id:  2000, invoice_id:  10000, result: "success" },
         { id:  3000, invoice_id:  20000, result: "failed" },
         { id:  4000, invoice_id:  20000, result: "failed" },
         { id:  5000, invoice_id:  30000, result: "success" },
         { id:  6000, invoice_id:  40000, result: "failed" },
         { id:  7000, invoice_id:  40000, result: "failed" },
         { id:  8000, invoice_id:  40000, result: "success" },
         { id:  9000, invoice_id:  50000, result: "failed" },
         { id: 10000, invoice_id:  50000, result: "success" }],
        sales_engine)
    sales_engine.invoice_item_repository = InvoiceItemRepository.new(
        [{ id:  100, invoice_id: 10000, item_id: 10, quantity: 2 },
         { id:  200, invoice_id: 20000, item_id: 20, quantity: 4 },
         { id:  300, invoice_id: 30000, item_id: 30, quantity: 2 },
         { id:  400, invoice_id: 40000, item_id: 40, quantity: 3 },
         { id:  500, invoice_id: 50000, item_id: 50, quantity: 1 },
         { id:  600, invoice_id: 50000, item_id: 60, quantity: 3 },
         { id:  700, invoice_id: 10000, item_id: 70, quantity: 2 },
         { id:  700, invoice_id: 10000, item_id: 80, quantity: 2 }],
        sales_engine)

    # TODO: Add InvoiceRepository and TransactionRepository
    # 1: 2 + 2 + 2 = 6
    # 2: 2
    # 3: 3 + 1 + 3 = 7
    # 1: 2 + 4 + 1 + 1 = 8, 2: 2 + 2 = 4, 3: 1 + 3 + 2 = 6
    assert_equal [3, 1], merchant_repo.most_items(2).map { |merchant| merchant.id }
  end
end


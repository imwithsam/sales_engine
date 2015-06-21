require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def test_find_by_invoice_id
    sales_engine = SalesEngine.new
    transaction_repo = TransactionRepository.new(
        [{ id: 10, invoice_id: 1 },
         { id: 20, invoice_id: 2 },
         { id: 30, invoice_id: 3 }],
        sales_engine)
    transaction = transaction_repo.find_by_invoice_id(2)

    assert_equal 20, transaction.id
  end

  def test_find_by_credit_card_number
    sales_engine = SalesEngine.new
    transaction_repo = TransactionRepository.new(
        [{ id: 10, credit_card_number: "4654405418249632" },
         { id: 20, credit_card_number: "4580251236515201" },
         { id: 30, credit_card_number: "4354495077693036" }],
        sales_engine)
    transaction = transaction_repo.find_by_credit_card_number("4580251236515201")

    assert_equal 20, transaction.id
  end

  def test_find_by_credit_card_expiration_date
    sales_engine = SalesEngine.new
    transaction_repo = TransactionRepository.new(
        [{ id: 10, credit_card_expiration_date: "2016-03-31" },
         { id: 20, credit_card_expiration_date: "2015-07-31" },
         { id: 30, credit_card_expiration_date: "2017-01-31" }],
        sales_engine)
    transaction = transaction_repo.find_by_credit_card_expiration_date("2015-07-31")

    assert_equal 20, transaction.id
  end

  def test_find_by_result
    sales_engine = SalesEngine.new
    transaction_repo = TransactionRepository.new(
        [{ id: 10, result: "success" },
         { id: 20, result: "failed" },
         { id: 30, result: "success" }],
        sales_engine)
    transaction = transaction_repo.find_by_result("failed")

    assert_equal 20, transaction.id
  end

  def test_find_all_by_invoice_id
    sales_engine = SalesEngine.new
    transaction_repo = TransactionRepository.new(
        [{ id: 10, invoice_id: 1 },
         { id: 20, invoice_id: 2 },
         { id: 30, invoice_id: 3 },
         { id: 40, invoice_id: 2 }],
        sales_engine)
    transactions = transaction_repo.find_all_by_invoice_id(2)

    assert_equal [20, 40], transactions.map { |transaction| transaction.id }
  end

  def test_find_all_by_credit_card_number
    sales_engine = SalesEngine.new
    transaction_repo = TransactionRepository.new(
        [{ id: 10, credit_card_number: "4654405418249632" },
         { id: 20, credit_card_number: "4580251236515201" },
         { id: 30, credit_card_number: "4354495077693036" },
         { id: 40, credit_card_number: "4580251236515201" }],
        sales_engine)
    transaction = transaction_repo.find_all_by_credit_card_number("4580251236515201")

    assert_equal [20, 40], transaction.map { |transaction| transaction.id }
  end

  def test_find_all_by_credit_card_expiration_date
    sales_engine = SalesEngine.new
    transaction_repo = TransactionRepository.new(
        [{ id: 10, credit_card_expiration_date: "2016-03-31" },
         { id: 20, credit_card_expiration_date: "2015-07-31" },
         { id: 30, credit_card_expiration_date: "2017-01-31" },
         { id: 40, credit_card_expiration_date: "2015-07-31" }],
        sales_engine)
    transactions = transaction_repo.find_all_by_credit_card_expiration_date("2015-07-31")

    assert_equal [20, 40], transactions.map { |transaction| transaction.id }
  end

  def test_find_all_by_result
    sales_engine = SalesEngine.new
    transaction_repo = TransactionRepository.new(
        [{ id: 10, result: "success" },
         { id: 20, result: "failed" },
         { id: 30, result: "success" },
         { id: 40, result: "failed" }],
        sales_engine)
    transactions = transaction_repo.find_all_by_result("failed")

    assert_equal [20, 40], transactions.map { |transaction| transaction.id }
  end
end


require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/invoice_item_repository'

class RepositoryTest < Minitest::Test
  def repositories
    [MerchantRepository,
     InvoiceRepository,
     ItemRepository,
     TransactionRepository,
     CustomerRepository,
     InvoiceItemRepository]
  end

  def test_returns_all_records
    sales_engine = SalesEngine.new

    self.repositories.each do |repository|
      repo = repository.new(
        [{ id: 1 }, { id: 2 }, { id: 3 }],
        sales_engine)
      records = repo.all

      assert_equal [1, 2, 3], records.map { |record| record.id }
    end
  end

  def test_returns_random_record
    sales_engine = SalesEngine.new

    self.repositories.each do |repository|
      repo = repository.new(
        [{ id: 1 }, { id: 2 }, { id: 3 }],
        sales_engine)
      random_match = false

      20.times do
        random_match = true if repo.random.id == 2
      end
      assert random_match, "Random ID did not match in 20 tries."
    end
  end

  def test_find_record_by_id
    record_id = 2
    sales_engine = SalesEngine.new

    self.repositories.each do |repository|
      repo = repository.new(
        [{ id: 1 }, { id: 2 }, { id: 3 }],
        sales_engine)
      record = repo.find_by_id(record_id)

      assert_equal 2, record.id
    end
  end

  def test_find_record_by_created_at
    record_created_at = "2014-02-04 10:21:16 UTC"
    sales_engine = SalesEngine.new

    self.repositories.each do |repository|
      repo = repository.new([
        { id: 1, created_at: "2014-07-14 11:01:15 UTC" },
        { id: 2, created_at: "2014-02-04 10:21:16 UTC" },
        { id: 3, created_at: "2015-06-18 11:20:44 UTC" }],
        sales_engine)
      record = repo.find_by_created_at(record_created_at)

      assert_equal 2, record.id
    end
  end

  def test_find_record_by_updated_at
    record_updated_at = "2014-02-05 18:01:32 UTC"
    sales_engine = SalesEngine.new

    self.repositories.each do |repository|
      repo = repository.new([
        { id: 1, updated_at: "2014-09-12 04:45:00 UTC" },
        { id: 2, updated_at: "2014-02-05 18:01:32 UTC" },
        { id: 3, updated_at: "2015-06-18 10:11:11 UTC" }],
        sales_engine)
      record = repo.find_by_updated_at(record_updated_at)

      assert_equal 2, record.id
    end
  end

  def test_find_all_records_by_id
    record_id = 2
    sales_engine = SalesEngine.new

    self.repositories.each do |repository|
      repo = repository.new(
          [{ id: 1 }, { id: 2 }, { id: 2 }, { id: 3 }],
          sales_engine)
      records = repo.find_all_by_id(record_id)

      assert_equal [2, 2], records.map { |record| record.id }
    end
  end

  def test_find_all_records_by_created_at
    record_created_at = "2014-02-04 10:21:16 UTC"
    sales_engine = SalesEngine.new

    self.repositories.each do |repository|
      repo = repository.new([
        { id: 1, created_at: "2014-07-14 11:01:15 UTC" },
        { id: 2, created_at: "2014-02-04 10:21:16 UTC" },
        { id: 3, created_at: "2015-06-18 11:20:44 UTC" },
        { id: 4, created_at: "2014-02-04 10:21:16 UTC" }],
        sales_engine)
      records = repo.find_all_by_created_at(record_created_at)

      assert_equal [2, 4], records.map { |record| record.id }
    end
  end

  def test_find_all_records_by_updated_at
    record_updated_at = "2014-02-05 18:01:32 UTC"
    sales_engine = SalesEngine.new

    self.repositories.each do |repository|
      repo = repository.new([
        { id: 1, updated_at: "2014-09-12 04:45:00 UTC" },
        { id: 2, updated_at: "2014-02-05 18:01:32 UTC" },
        { id: 3, updated_at: "2015-06-18 10:11:11 UTC" },
        { id: 4, updated_at: "2014-02-05 18:01:32 UTC" }],
        sales_engine)
      records = repo.find_all_by_updated_at(record_updated_at)

      assert_equal [2, 4], records.map { |record| record.id }
    end
  end
end

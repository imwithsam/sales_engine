require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def test_find_by_first_name
    sales_engine = SalesEngine.new
    customer_repo = CustomerRepository.new(
        [{ id: 10, first_name: "Jane" },
         { id: 20, first_name: "John" },
         { id: 30, first_name: "Antonio" }],
        sales_engine)
    customer = customer_repo.find_by_first_name("John")

    assert_equal 20, customer.id
  end

  def test_find_by_last_name
    sales_engine = SalesEngine.new
    customer_repo = CustomerRepository.new(
        [{ id: 10, last_name: "Doe" },
         { id: 20, last_name: "Smith" },
         { id: 30, last_name: "Fernandez" }],
        sales_engine)
    customer = customer_repo.find_by_last_name("Smith")

    assert_equal 20, customer.id
  end

  def test_find_all_by_first_name
    sales_engine = SalesEngine.new
    customer_repo = CustomerRepository.new(
        [{ id: 10, first_name: "Jane" },
         { id: 20, first_name: "John" },
         { id: 30, first_name: "Antonio" },
         { id: 40, first_name: "John" }],
        sales_engine)
    customers = customer_repo.find_all_by_first_name("John")

    assert_equal [20, 40], customers.map { |customer| customer.id }
  end

  def test_find_all_by_last_name
    sales_engine = SalesEngine.new
    customer_repo = CustomerRepository.new(
        [{ id: 10, last_name: "Doe" },
         { id: 20, last_name: "Smith" },
         { id: 30, last_name: "Fernandez" },
         { id: 40, last_name: "Smith" }],
        sales_engine)
    customers = customer_repo.find_all_by_last_name("Smith")

    assert_equal [20, 40], customers.map { |customer| customer.id }
  end
end


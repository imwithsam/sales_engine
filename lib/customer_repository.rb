require_relative 'repository'
require_relative 'customer'

class CustomerRepository < Repository
  def record_type
    Customer
  end

  def find_by_first_name(first_name)
    all.detect { |record| record.first_name == first_name }
  end

  def find_by_last_name(last_name)
    all.detect { |record| record.last_name == last_name }
  end

  def find_all_by_first_name(first_name)
    all.select { |record| record.first_name == first_name }
  end

  def find_all_by_last_name(last_name)
    all.select { |record| record.last_name == last_name }
  end
end



require_relative 'repository'
require_relative 'customer'

class CustomerRepository < Repository
  def record_type
    Customer
  end

  def find_by_first_name(first_name)
    @find_by_first_name ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.first_name == key }
    end
    @find_by_first_name[first_name]
  end

  def find_by_last_name(last_name)
    @find_by_last_name ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.last_name == key }
    end
    @find_by_last_name[last_name]
  end

  def find_all_by_first_name(first_name)
    @find_all_by_first_name ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.first_name == key }
    end
    @find_all_by_first_name[first_name]
  end

  def find_all_by_last_name(last_name)
    @find_all_by_last_name ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.last_name == key }
    end
    @find_all_by_last_name[last_name]
  end
end



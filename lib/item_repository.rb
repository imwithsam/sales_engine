require_relative 'repository'
require_relative 'item'

class ItemRepository < Repository
  def record_type
    Item
  end

  def find_by_name(name)
    all.detect { |record| record.name == name }
  end

  def find_by_description(description)
    all.detect { |record| record.description == description }
  end

  def find_by_unit_price(price)
    all.detect { |record| record.unit_price == price }
  end

  def find_by_merchant_id(merchant_id)
    all.detect { |record| record.merchant_id == merchant_id }
  end

  def find_all_by_name(name)
    all.select { |record| record.name == name }
  end

  def find_all_by_description(description)
    all.select { |record| record.description == description }
  end

  def find_all_by_unit_price(price)
    all.select { |record| record.unit_price == price }
  end

  def find_all_by_merchant_id(merchant_id)
    all.select { |record| record.merchant_id == merchant_id }
  end
end
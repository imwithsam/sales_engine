require_relative 'repository'
require_relative 'item'

class ItemRepository < Repository
  def record_type
    Item
  end

  def find_by_name(name)
    @find_by_name ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.name == key }
    end
    @find_by_name[name]
  end

  def find_by_description(description)
    @find_by_description ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.description == key }
    end
    @find_by_description[description]
  end

  def find_by_unit_price(price)
    @find_by_unit_price ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.unit_price == key }
    end
    @find_by_unit_price[price]
  end

  def find_by_merchant_id(merchant_id)
    @find_by_merchant_id ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.merchant_id == key }
    end
    @find_by_merchant_id[merchant_id]
  end

  def find_all_by_name(name)
    @find_all_by_name ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.name == key }
    end
    @find_all_by_name[name]
  end

  def find_all_by_description(description)
    @find_all_by_description ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.description == key }
    end
    @find_all_by_description[description]
  end

  def find_all_by_unit_price(price)
    @find_all_by_unit_price ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.unit_price == key }
    end
    @find_all_by_unit_price[price]
  end

  def find_all_by_merchant_id(merchant_id)
    @find_all_by_merchant_id ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.merchant_id == key }
    end
    @find_all_by_merchant_id[merchant_id]
  end

  def most_revenue(number_of_items)
    @most_revenue ||= Hash.new do |h, key|
      h[key] = all.sort_by(&:revenue).reverse.take(key)
    end
    @most_revenue[number_of_items]
  end

  def most_items(number_of_items)
    @most_items ||= Hash.new do |h, key|
      h[key] = all.sort_by(&:quantity).reverse.take(key)
    end
    @most_items[number_of_items]
  end
end


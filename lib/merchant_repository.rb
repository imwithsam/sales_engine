require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository
  def record_type
    Merchant
  end

  def find_by_name(name)
    @find_by_name ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.name == key }
    end
    @find_by_name[name]
  end

  def find_all_by_name(name)
    @find_all_by_name ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.name == key }
    end
    @find_all_by_name[name]
  end

  def most_revenue(number_of_merchants)
    @most_revenue ||= Hash.new do |h, key|
      h[key] = all.sort_by(&:revenue).reverse.take(key)
    end
    @most_revenue[number_of_merchants]
  end

  def most_items(number_of_merchants)
    @most_items ||= Hash.new do |h, key|
      h[key] = all.sort_by(&:total_items_sold).reverse.take(key)
    end
    @most_items[number_of_merchants]
  end

  def revenue(date)
    @revenue ||= Hash.new do |h, key|
      h[key] = all.reduce(0) { |sum, merchant| sum + merchant.revenue(key) }
    end
    @revenue[date]
  end
end

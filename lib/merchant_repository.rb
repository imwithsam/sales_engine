require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository
  def record_type
    Merchant
  end

  def find_by_name(name)
    all.detect { |record| record.name == name }
  end

  def find_all_by_name(name)
    all.select { |record| record.name == name }
  end

  def most_revenue(number_of_merchants)
    all.sort_by(&:revenue).reverse.take(number_of_merchants)
  end

  def most_items(number_of_merchants)
    # returns the top x merchant instances ranked by total number of items sold
    all.sort_by(&:total_items_sold).reverse.take(number_of_merchants)
  end
end

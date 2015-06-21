require_relative 'record'

class Item < Record
  def name
    attributes[:name]
  end

  def description
    attributes[:description]
  end

  def unit_price
    attributes[:unit_price]
  end

  def merchant_id
    attributes[:merchant_id]
  end
end

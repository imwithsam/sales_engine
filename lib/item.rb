require 'bigdecimal'
require_relative 'record'

class Item < Record
  def name
    attributes[:name]
  end

  def description
    attributes[:description]
  end

  def unit_price
    BigDecimal.new(attributes[:unit_price]) / 100
  end

  def merchant_id
    attributes[:merchant_id].to_i
  end

  def invoice_items
    self.repository.engine.invoice_item_repository.find_all_by_item_id(self.id)
  end

  def merchant
    self.repository.engine.merchant_repository.find_by_id(self.merchant_id)
  end
end

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
    repository.engine.invoice_item_repository.find_all_by_item_id(id)
  end

  def merchant
    repository.engine.merchant_repository.find_by_id(merchant_id)
  end

  def revenue
    invoice_items.reduce(0) do |sum, invoice_item|
      if invoice_item.invoice.paid?
        sum + (invoice_item.quantity * invoice_item.unit_price)
      else
        sum
      end
    end
  end

  def quantity
    invoice_items.reduce(0) do |sum, invoice_item|
      if invoice_item.invoice.paid?
        sum + invoice_item.quantity
      else
        sum
      end
    end
  end
end

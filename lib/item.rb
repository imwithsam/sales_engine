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

  def paid_invoice_items
    invoice_items.select { |invoice_item| invoice_item.invoice.paid? }
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

  def best_day
    invoice_items_by_date = paid_invoice_items.group_by do |invoice_item|
      invoice_item.invoice.created_at
    end

    best_day = invoice_items_by_date.max_by do |date, invoice_items|
      invoice_items.reduce(0) do |sum, invoice_item|
        sum + invoice_item.revenue
      end
    end

    best_day[0]
  end
end

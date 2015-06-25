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
    return @unit_price if defined? @unit_price
    @unit_price = BigDecimal.new(attributes[:unit_price]) / 100
  end

  def merchant_id
    return @merchant_id if defined? @merchant_id
    @merchant_id = attributes[:merchant_id].to_i
  end

  def invoice_items
    return @invoice_items if defined? @invoice_items
    @invoice_items = repository.engine.invoice_item_repository
                         .find_all_by_item_id(id)
  end

  def paid_invoice_items
    return @paid_invoice_items if defined? @paid_invoice_items
    @paid_invoice_items = invoice_items
      .select { |invoice_item| invoice_item.invoice.paid? }
  end

  def merchant
    return @merchant if defined? @merchant
    @merchant = repository.engine.merchant_repository
                    .find_by_id(merchant_id)
  end

  def revenue
    return @revenue if defined? @revenue
    @revenue = invoice_items.reduce(0) do |sum, invoice_item|
      if invoice_item.invoice.paid?
        sum + (invoice_item.quantity * invoice_item.unit_price)
      else
        sum
      end
    end
  end

  def quantity
    return @quantity if defined? @quantity
    @quantity = invoice_items.reduce(0) do |sum, invoice_item|
      if invoice_item.invoice.paid?
        sum + invoice_item.quantity
      else
        sum
      end
    end
  end

  def best_day
    return @best_day if defined? @best_day
    invoice_items_by_date = paid_invoice_items.group_by do |invoice_item|
      invoice_item.invoice.created_at
    end

    best_day = invoice_items_by_date.max_by do |date, invoice_items|
      invoice_items.reduce(0) do |sum, invoice_item|
        sum + invoice_item.revenue
      end
    end

    @best_day = best_day[0]
  end
end

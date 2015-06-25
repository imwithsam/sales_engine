require 'bigdecimal'
require_relative 'record'

class InvoiceItem < Record
  def item_id
    return @item_id if defined? @item_id
    @item_id = attributes[:item_id].to_i
  end

  def invoice_id
    return @invoice_id if defined? @invoice_id
    @invoice_id = attributes[:invoice_id].to_i
  end

  def quantity
    return @quantity if defined? @quantity
    @quantity = attributes[:quantity].to_i
  end

  def unit_price
    return @unit_price if defined? @unit_price
    @unit_price = BigDecimal.new(attributes[:unit_price]) / 100
  end

  def revenue
    return @revenue if defined? @revenue
    @revenue = quantity * unit_price
  end

  def invoice
    return @invoice if defined? @invoice
    @invoice = repository.engine.invoice_repository.find_by_id(invoice_id)
  end

  def item
    return @item if defined? @item
    @item = repository.engine.item_repository.find_by_id(item_id)
  end
end


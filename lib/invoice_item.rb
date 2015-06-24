require 'bigdecimal'
require_relative 'record'

class InvoiceItem < Record
  def item_id
    attributes[:item_id].to_i
  end

  def invoice_id
    attributes[:invoice_id].to_i
  end

  def quantity
    attributes[:quantity].to_i
  end

  def unit_price
    BigDecimal.new(attributes[:unit_price]) / 100
  end

  def revenue
    quantity * unit_price
  end

  def invoice
    repository.engine.invoice_repository.find_by_id(invoice_id)
  end

  def item
    repository.engine.item_repository.find_by_id(item_id)
  end
end


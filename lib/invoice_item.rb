require_relative 'record'

class InvoiceItem < Record
  def item_id
    attributes[:item_id]
  end

  def invoice_id
    attributes[:invoice_id]
  end

  def quantity
    attributes[:quantity]
  end

  def unit_price
    attributes[:unit_price]
  end

  def invoice
    self.repository.engine.invoice_repository.find_by_id(self.invoice_id)
  end

  def item
    self.repository.engine.item_repository.find_by_id(self.item_id)
  end
end


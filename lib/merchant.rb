require_relative 'record'

class Merchant < Record
  def name
    attributes[:name]
  end

  def items
    self.repository.engine.item_repository.find_all_by_merchant_id(self.id)
  end

  def invoices
    self.repository.engine.invoice_repository.find_all_by_merchant_id(self.id)
  end
end


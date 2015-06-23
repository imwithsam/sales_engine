require_relative 'record'

class Invoice < Record
  def customer_id
    attributes[:customer_id].to_i
  end

  def merchant_id
    attributes[:merchant_id].to_i
  end

  def status
    attributes[:status]
  end

  def transactions
    self.repository.engine.transaction_repository.find_all_by_invoice_id(self.id)
  end

  def invoice_items
    self.repository.engine.invoice_item_repository.find_all_by_invoice_id(self.id)
  end

  def items
    self.invoice_items.map do |invoice_item|
      self.repository.engine.item_repository.find_by_id(invoice_item.item_id)
    end
  end

  def customer
    self.repository.engine.customer_repository.find_by_id(self.customer_id)
  end

  def merchant
    self.repository.engine.merchant_repository.find_by_id(self.merchant_id)
  end

  def successful_transaction?
    transactions.any? { |transaction| transaction.result == "success" }
  end
end


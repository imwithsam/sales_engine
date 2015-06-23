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
    repository.engine.transaction_repository.find_all_by_invoice_id(id)
  end

  def invoice_items
    repository.engine.invoice_item_repository.find_all_by_invoice_id(id)
  end

  def items
    invoice_items.map do |invoice_item|
      repository.engine.item_repository.find_by_id(invoice_item.item_id)
    end
  end

  def customer
    repository.engine.customer_repository.find_by_id(customer_id)
  end

  def merchant
    repository.engine.merchant_repository.find_by_id(merchant_id)
  end

  def successful_transaction?
    transactions.any? { |transaction| transaction.result == "success" }
  end
end


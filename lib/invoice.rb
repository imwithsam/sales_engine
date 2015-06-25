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

  def paid?
    transactions.any? { |transaction| transaction.successful? }
  end

  def grand_total
    invoice_items.reduce(0) do |subtotal, item|
      subtotal + (item.quantity * item.unit_price)
    end
  end

  def charge(attributes)
    cc_number = attributes[:credit_card_number]
    cc_expiration = attributes[:credit_card_expiration]
    result = attributes[:result]
    transaction_attributes = {
        invoice_id: id,
        credit_card_number: cc_number,
        credit_card_expiration_date: cc_expiration,
        result: result
    }
    repository.engine.transaction_repository.create(transaction_attributes)
  end
end


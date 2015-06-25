require_relative 'record'

class Invoice < Record
  def customer_id
    return @customer_id if defined? @customer_id
    @customer_id = attributes[:customer_id].to_i
  end

  def merchant_id
    return @merchant_id if defined? @merchant_id
    @merchant_id = attributes[:merchant_id].to_i
  end

  def status
    attributes[:status]
  end

  def transactions
    # Do NOT memoize. Spec Harness will fail if memoized.
    repository.engine.transaction_repository.find_all_by_invoice_id(id)
  end

  def invoice_items
    return @invoice_items if defined? @invoice_items
    @invoice_items = repository.engine.invoice_item_repository
                         .find_all_by_invoice_id(id)
  end

  def items
    return @items if defined? @items
    @items = invoice_items.map do |invoice_item|
      repository.engine.item_repository.find_by_id(invoice_item.item_id)
    end
  end

  def customer
    return @customer if defined? @customer
    @customer = repository.engine.customer_repository.find_by_id(customer_id)
  end

  def merchant
    return @merchant if defined? @merchant
    @merchant = repository.engine.merchant_repository.find_by_id(merchant_id)
  end

  def paid?
    transactions.any? { |transaction| transaction.successful? }
  end

  def grand_total
    return @grand_total if defined? @grand_total
    @grand_total = invoice_items.reduce(0) do |subtotal, item|
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


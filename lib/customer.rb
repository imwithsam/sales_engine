require_relative 'record'

class Customer < Record
  def first_name
    attributes[:first_name]
  end

  def last_name
    attributes[:last_name]
  end

  def invoices
    return @invoices if defined? @invoices
    @invoices = repository.engine.invoice_repository
                    .find_all_by_customer_id(id)
  end

  def paid_invoices
    return @paid_invoices if defined? @paid_invoices
    @paid_invoices = invoices.select(&:paid?)
  end

  def transactions
    return @transactions if defined? @transactions
    @transactions = invoices.flat_map do |invoice|
      repository.engine.transaction_repository
          .find_all_by_invoice_id(invoice.id)
    end
  end

  def favorite_merchant
    return @favorite_merchant if defined? @favorite_merchant
    invoices_by_merchant_id = paid_invoices.group_by do |invoice|
      invoice.merchant_id
    end

    merchant = invoices_by_merchant_id.max_by do |merchant_id, invoices|
      invoices.count
    end

    @favorite_merchant = repository.engine.merchant_repository
                          .find_by_id(merchant[0])
  end
end


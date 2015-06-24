require_relative 'record'

class Customer < Record
  def first_name
    attributes[:first_name]
  end

  def last_name
    attributes[:last_name]
  end

  def invoices
    repository.engine.invoice_repository.find_all_by_customer_id(id)
  end

  def paid_invoices
    invoices.select(&:paid?)
  end

  def transactions
    invoices.flat_map do |invoice|
      repository.engine.transaction_repository.find_all_by_invoice_id(invoice.id)
    end
  end

  def favorite_merchant
    invoices_by_merchant_id = paid_invoices.group_by do |invoice|
      invoice.merchant_id
    end

    merchant = invoices_by_merchant_id.max_by do |merchant_id, invoices|
      invoices.count
    end

    repository.engine.merchant_repository.find_by_id(merchant[0])
  end
end


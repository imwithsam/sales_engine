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

  def transactions
    invoices.flat_map do |invoice|
      repository.engine.transaction_repository.find_all_by_invoice_id(invoice.id)
    end
  end
end


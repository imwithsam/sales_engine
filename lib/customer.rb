require_relative 'record'

class Customer < Record
  def first_name
    attributes[:first_name]
  end

  def last_name
    attributes[:last_name]
  end

  def invoices
    self.repository.engine.invoice_repository.find_all_by_customer_id(self.id)
  end
end


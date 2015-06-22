require_relative 'record'

class Transaction < Record
  def invoice_id
    attributes[:invoice_id].to_i
  end

  def credit_card_number
    attributes[:credit_card_number]
  end

  def credit_card_expiration_date
    attributes[:credit_card_expiration_date]
  end

  def result
    attributes[:result]
  end

  def invoice
    self.repository.engine.invoice_repository.find_by_id(self.invoice_id)
  end
end


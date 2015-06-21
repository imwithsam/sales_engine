require_relative 'record'

class Transaction < Record
  def invoice_id
    attributes[:invoice_id]
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
end


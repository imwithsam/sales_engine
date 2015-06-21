require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository
  def record_type
    Transaction
  end

  def find_by_invoice_id(invoice_id)
    all.detect { |record| record.invoice_id == invoice_id }
  end

  def find_by_credit_card_number(credit_card_number)
    all.detect { |record| record.credit_card_number == credit_card_number }
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    all.detect { |record| record.credit_card_expiration_date == credit_card_expiration_date }
  end

  def find_by_result(result)
    all.detect { |record| record.result == result }
  end

  def find_all_by_invoice_id(invoice_id)
    all.select { |record| record.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.select { |record| record.credit_card_number == credit_card_number }
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    all.select { |record| record.credit_card_expiration_date == credit_card_expiration_date }
  end

  def find_all_by_result(result)
    all.select { |record| record.result == result }
  end
end


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

  def create(attributes)
    invoice_id = attributes[:invoice_id]
    cc_number = attributes[:credit_card_number]
    cc_expiration = attributes[:credit_card_expiration_date]
    result = attributes[:result]
    transaction_attributes = {
        id: next_unused_id,
        invoice_id: invoice_id,
        credit_card_number: cc_number,
        credit_card_expiration_date: cc_expiration,
        result: result,
        created_at: format_date_time(DateTime.now),
        updated_at: format_date_time(DateTime.now)
    }
    transaction = Transaction.new(transaction_attributes, self)
    all << transaction

    transaction
  end
end


require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository
  def record_type
    Transaction
  end

  def find_by_invoice_id(invoice_id)
    @find_by_invoice_id ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.invoice_id == key }
    end
    @find_by_invoice_id[invoice_id]
  end

  def find_by_credit_card_number(credit_card_number)
    @find_by_credit_card_number ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.credit_card_number == key }
    end
    @find_by_credit_card_number[credit_card_number]
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    @find_by_credit_card_expiration_date ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.credit_card_expiration_date == key }
    end
    @find_by_credit_card_expiration_date[credit_card_expiration_date]
  end

  def find_by_result(result)
    @find_by_result ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.result == key }
    end
    @find_by_result[result]
  end

  def find_all_by_invoice_id(invoice_id)
    # Do NOT memoize. Spec Harness will fail if memoized.
    all.select { |record| record.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(credit_card_number)
    @find_all_by_credit_card_number ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.credit_card_number == key }
    end
    @find_all_by_credit_card_number[credit_card_number]
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    @find_all_by_credit_card_expiration_date ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.credit_card_expiration_date == key }
    end
    @find_all_by_credit_card_expiration_date[credit_card_expiration_date]
  end

  def find_all_by_result(result)
    @find_all_by_result ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.result == key }
    end
    @find_all_by_result[result]
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


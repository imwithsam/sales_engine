require_relative 'repository'
require_relative 'invoice'

class InvoiceRepository < Repository
  def record_type
    Invoice
  end

  def find_by_customer_id(customer_id)
    all.detect { |record| record.customer_id == customer_id }
  end

  def find_by_merchant_id(merchant_id)
    all.detect { |record| record.merchant_id == merchant_id }
  end

  def find_by_status(status)
    all.detect { |record| record.status == status }
  end

  def find_all_by_customer_id(customer_id)
    all.select { |record| record.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    all.select { |record| record.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    all.select { |record| record.status == status }
  end
end


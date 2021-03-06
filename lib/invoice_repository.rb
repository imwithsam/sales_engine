require_relative 'repository'
require_relative 'invoice'

class InvoiceRepository < Repository
  def record_type
    Invoice
  end

  def find_by_customer_id(customer_id)
    @find_by_customer_id ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.customer_id == key }
    end
    @find_by_customer_id[customer_id]
  end

  def find_by_merchant_id(merchant_id)
    @find_by_merchant_id ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.merchant_id == key }
    end
    @find_by_merchant_id[merchant_id]
  end

  def find_by_status(status)
    @find_by_status ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.status == key }
    end
    @find_by_status[status]
  end

  def find_all_by_customer_id(customer_id)
    @find_all_by_customer_id ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.customer_id == key }
    end
    @find_all_by_customer_id[customer_id]
  end

  def find_all_by_merchant_id(merchant_id)
    @find_all_by_merchant_id ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.merchant_id == key }
    end
    @find_all_by_merchant_id[merchant_id]
  end

  def find_all_by_status(status)
    @find_all_by_status ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.status == key }
    end
    @find_all_by_status[status]
  end

  def create(attributes)
    customer = attributes[:customer]
    merchant = attributes[:merchant]
    status = attributes[:status]
    items = attributes[:items]
    invoice_attributes = {
       id: next_unused_id,
       customer_id: customer.id,
       merchant_id: merchant.id,
       status: status,
       created_at: format_date_time(DateTime.now),
       updated_at: format_date_time(DateTime.now)
    }
    invoice = Invoice.new(invoice_attributes, self)
    all << invoice

    quantities = item_quantities(items)
    items.each do |item|
      invoice_item_attributes = {
          item: item,
          invoice_id: invoice.id,
          quantity: quantities[item.id],
      }

      engine.invoice_item_repository.create(invoice_item_attributes)
    end

    invoice
  end

  private

  def item_quantities(items)
    items_by_item_id = items.group_by(&:id)
    items_by_item_id.map do |item_id, items|
      { item_id => items.count }
    end
  end
end


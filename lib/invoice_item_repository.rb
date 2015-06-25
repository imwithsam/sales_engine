require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository
  def record_type
    InvoiceItem
  end

  def find_by_item_id(item_id)
    @find_by_item_id ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.item_id == key }
    end
    @find_by_item_id[item_id]
  end

  def find_by_invoice_id(invoice_id)
    @find_by_invoice_id ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.invoice_id == key }
    end
    @find_by_invoice_id[invoice_id]
  end

  def find_by_quantity(quantity)
    @find_by_quantity ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.quantity == key }
    end
    @find_by_quantity[quantity]
  end

  def find_by_unit_price(unit_price)
    @find_by_unit_price ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.unit_price == key }
    end
    @find_by_unit_price[unit_price]
  end

  def find_all_by_item_id(item_id)
    @find_all_by_item_id ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.item_id == key }
    end
    @find_all_by_item_id[item_id]
  end

  def find_all_by_invoice_id(invoice_id)
    @find_all_by_invoice_id ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.invoice_id == key }
    end
    @find_all_by_invoice_id[invoice_id]
  end

  def find_all_by_quantity(quantity)
    @find_all_by_quantity ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.quantity == key }
    end
    @find_all_by_quantity[quantity]
  end

  def find_all_by_unit_price(unit_price)
    @find_all_by_unit_price ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.unit_price == key }
    end
    @find_all_by_unit_price[unit_price]
  end

  def create(attributes)
    item = attributes[:item]
    invoice_id = attributes[:invoice_id]
    quantity = attributes[:quantity]
    invoice_item_attributes = {
        id: next_unused_id,
        item_id: item.id,
        invoice_id: invoice_id,
        quantity: quantity,
        unit_price: item.unit_price,
        created_at: format_date_time(DateTime.now),
        updated_at: format_date_time(DateTime.now)
    }
    invoice_item = InvoiceItem.new(invoice_item_attributes, self)
    all << invoice_item

    invoice_item
  end
end



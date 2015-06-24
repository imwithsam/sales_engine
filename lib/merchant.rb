require 'bigdecimal'
require 'date'
require_relative 'record'

class Merchant < Record
  def name
    attributes[:name]
  end

  def items
    repository.engine.item_repository.find_all_by_merchant_id(id)
  end

  def invoices
    repository.engine.invoice_repository.find_all_by_merchant_id(id)
  end

  def paid_invoices
    invoices.select(&:paid?)
  end

  def unpaid_invoices
    invoices.reject(&:paid?)
  end

  def revenue(date = nil)
    if date.is_a?(Date)
      paid_invoices.reduce(0) do |total, invoice|
         if invoice.created_at == date
           total + invoice.grand_total
         else
           total
         end
      end
    else
      paid_invoices.reduce(0) do |total, invoice|
        total + invoice.grand_total
      end
    end
  end

  def total_items_sold
    # invoice_item only counts if invoice is paid
    item_sums = items.map do |item|
      item.invoice_items.reduce(0) do |sum, i|
        if repository.engine.invoice_repository.find_by_id(i.invoice_id).paid?
          sum + i.quantity
        else
          sum
        end
      end
    end

    item_sums.reduce(:+)
  end

  def favorite_customer
    grouped_invoices = paid_invoices.group_by(&:customer_id)
    favorite_customer_id = grouped_invoices.sort_by { |k, v| v.count }.last[0]
    repository.engine.customer_repository.find_by_id(favorite_customer_id)
  end

  def customers_with_pending_invoices
    customers = unpaid_invoices.map do |invoice|
      repository.engine.customer_repository.find_by_id(invoice.customer_id)
    end

    customers.uniq
  end
end


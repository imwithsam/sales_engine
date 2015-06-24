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

  def revenue(date = nil)
    paid_invoices = invoices.select do |invoice|
      invoice.paid?
    end

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
end


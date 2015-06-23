require 'bigdecimal'
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

  def revenue
    paid_invoices = invoices.select do |invoice|
      invoice.paid?
    end

    paid_invoices.reduce(0) do |total, invoice|
      total + invoice.grand_total
    end
  end
end


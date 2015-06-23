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
      invoice.successful_transaction?
    end

    paid_invoices.reduce(0) do |total, invoice|
      total + revenue_for_invoice(invoice)
    end
  end

  private

  def revenue_for_invoice(invoice)
    invoice.invoice_items.reduce(0) do |subtotal, item|
      subtotal + (item.quantity * item.unit_price)
    end
  end
end


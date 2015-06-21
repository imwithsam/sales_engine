require_relative 'record'

class Invoice < Record
  def customer_id
    attributes[:customer_id]
  end

  def merchant_id
    attributes[:merchant_id]
  end
end


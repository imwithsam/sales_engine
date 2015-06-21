require_relative 'record'

class Merchant < Record
  def name
    attributes[:name]
  end
end


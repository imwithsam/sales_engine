require_relative 'record'

class Customer < Record
  def first_name
    attributes[:first_name]
  end

  def last_name
    attributes[:last_name]
  end
end


require 'csv'

class Merchant
  attr_accessor :id,
                :name,
                :created_at,
                :updated_at

  def read_file
    CSV.foreach('./data/merchants_test.csv', headers: true, header_converters: :symbol) do |row|
      puts row[:id]
      puts row[:name]
      puts row[:created_at]
      puts row[:updated_at]
    end
  end
end

# MerchantRepository
# read CSV
# for each row => Merchant.new
# merchant.id = row[:id]

# Merchant
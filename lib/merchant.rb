class Merchant
  attr_accessor :id,
                :name,
                :created_at,
                :updated_at

  def initialize(merchant_parser)
    @parser = merchant_parser
  end
end






# MerchantRepository
# read CSV
# for each row => Merchant.new
# merchant.id = row[:id]

# Merchant


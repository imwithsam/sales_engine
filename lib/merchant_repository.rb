class MerchantRepository

  attr_accessor :merchant_csv

  def initialize(file_name)
    self.merchant_csv = file_name
  end

  def all
    parser = MerchantParser.new(self)
    parser.parse(merchant_csv)
  end

end



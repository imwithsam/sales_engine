class MerchantParser
  def initialize(merchant_repository)
    @repository = merchant_repository
  end

  def parse(file_name)
    csv = CsvReader.new
    rows = csv.file_read(file_name)
    rows.map do |row|
      create_merchant(row)
    end
  end

  def create_merchant(row)
    merchant = Merchant.new(self)
    merchant.id         = row[:id].to_i
    merchant.name       = row[:name]
    merchant.created_at = row[:created_at]
    merchant.updated_at = row[:updated_at]
    merchant
  end
end


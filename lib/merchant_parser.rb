# class MerchantParser
#   def initialize(merchant_repository)
#     @repository = merchant_repository
#   end
#
#   def parse(file_name)
#     rows = CsvReader.read(file_name)
#     rows.map { |row| Merchant.new(row.to_hash, self) }
#   end
# end
#

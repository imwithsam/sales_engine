require_relative 'csv_reader'
require_relative 'merchant_repository'

class SalesEngine

  attr_accessor :merchant_repository,
                :invoice_repository,
                :item_repository,
                :invoice_item_repository,
                :customer_repository,
                :transaction_repository

  def initialize
    @data_directory = File.expand_path('../data', __dir__)
  end

  def startup
    merchant_records = CsvReader.read("#{@data_directory}/merchants.csv")
    self.merchant_repository = MerchantRepository.new(merchant_records, self)
    require 'pry'; binding.pry
  end
end

engine = SalesEngine.new
engine.startup

require_relative 'csv_reader'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_accessor :data_directory,
                :merchant_repository,
                :invoice_repository,
                :item_repository,
                :invoice_item_repository,
                :customer_repository,
                :transaction_repository

  def initialize(data_directory = File.expand_path('../data', __dir__))
    self.data_directory = data_directory
  end

  def startup
    merchant_records = CsvReader.read("#{data_directory}/merchants.csv")
    self.merchant_repository = MerchantRepository.new(merchant_records, self)

    invoice_records = CsvReader.read("#{data_directory}/invoices.csv")
    self.invoice_repository = InvoiceRepository.new(invoice_records, self)

    item_records = CsvReader.read("#{data_directory}/items.csv")
    self.item_repository = ItemRepository.new(item_records, self)

    transaction_records = CsvReader.read("#{data_directory}/transactions.csv")
    self.transaction_repository = TransactionRepository.new(transaction_records, self)

    customer_records = CsvReader.read("#{data_directory}/customers.csv")
    self.customer_repository = CustomerRepository.new(customer_records, self)

    invoice_item_records = CsvReader.read("#{data_directory}/invoice_items.csv")
    self.invoice_item_repository = InvoiceItemRepository.new(invoice_item_records, self)
  end
end

# engine = SalesEngine.new
# engine.startup

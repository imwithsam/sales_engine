require_relative 'repository'
require_relative 'merchant_parser'
require_relative 'merchant'

class MerchantRepository < Repository
  def parser
    MerchantParser
  end

  def record_type
    Merchant
  end

  def find_by_name(name)
    all.detect { |record| record.name == name }
  end

  def find_all_by_name(name)
    all.select { |record| record.name == name }
  end
end

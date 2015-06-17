require_relative('repository')

class MerchantRepository < Repository
  def parser
    MerchantParser
  end

  def find_by_name(name)
    all.detect { |record| record.name == name }
  end

  def find_all_by_name(name)
    all.select { |record| record.name == name }
  end
end

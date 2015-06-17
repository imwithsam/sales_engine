class Item
  attr_reader :id,
              :name,
              :description
              # etc.

  # data is a hash
  def initialize(data, repo)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:item_price]
    @merchant_id = data[:@merchant_id]
    @created_at = data[:@created_at]
    @updated_at = data[:@updated_at]
    @repository = repo
  end

  def merchant
    self.repository.find_merchant(merchant_id)
  end
end

class ItemRepository
  def initialize(rows, sales_engine)
    @sales_engine = sales_engine
  end

  def method_name
    rows.map do |row|
      Item.new(row, self)
    end
  end

  def find_by_name(value)
    @items.find { |item| item.name == value }
  end

  def find_merchant(merchant_id)
    @sales_engine.find_merchant(merchant_id)
  end
end

class SalesEngine
  def method_name
    @item_repository = ItemRepository.new(rows, self)
  end

  def merchant
    self.repository.find_merchant(merchant_id)
  end

  def find_merchant(merchant_id)
    @merchant_repository.find_by_id(merchant_id)
  end
end

# Going up the chain
# item.repository.sales_engine

# Going down the chain
# engine.item_repository.item("item_id")

# Don't parse CSVs for the smallest unit tests. Hard-code a row as a hash instead.

# See Rachel about testing using Mock Objects (don't use the real Repo Objects).


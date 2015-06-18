class Merchant
  attr_accessor :repository,
                :attributes

  def initialize(attributes, repository)
    self.attributes = attributes
    self.repository = repository
  end

  def id
    attributes[:id]
  end

  def name
    attributes[:name]
  end

  def created_at
    attributes[:created_at]
  end

  def updated_at
    attributes[:updated_at]
  end
end


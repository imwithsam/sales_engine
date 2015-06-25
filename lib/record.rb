require 'date'

class Record
  attr_accessor :attributes,
                :repository

  def initialize(attributes, repository)
    self.attributes = attributes
    self.repository = repository
  end

  def id
    attributes[:id].to_i
  end

  def created_at
    Date.parse(attributes[:created_at])
  end

  def updated_at
    Date.parse(attributes[:updated_at])
  end
end
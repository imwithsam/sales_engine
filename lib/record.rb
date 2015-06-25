require 'date'

class Record
  attr_accessor :attributes,
                :repository

  def initialize(attributes, repository)
    self.attributes = attributes
    self.repository = repository
  end

  def id
    return @id if defined? @id
    @id = attributes[:id].to_i
  end

  def created_at
    return @created_at if defined? @created_at
    @created_at = Date.parse(attributes[:created_at])
  end

  def updated_at
    return @updated_at if defined? @updated_at
    @updated_at = Date.parse(attributes[:updated_at])
  end
end
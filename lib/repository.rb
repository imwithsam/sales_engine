class Repository
  attr_accessor :file_name

  def initialize(file_name)
    self.file_name = file_name
  end

  def all
    parser = self.parser.new(self)
    parser.parse(self.file_name)
  end

  def random
    all.sample
  end
  
  def find_by_id(id)
    all.detect { |record| record.id == id }
  end

  def find_by_created_at(date)
    all.detect { |record| record.created_at == date }
  end

  def find_by_updated_at(date)
    all.detect { |record| record.updated_at == date }
  end

  def find_all_by_id(id)
    all.select { |record| record.id == id }
  end

  def find_all_by_created_at(date)
    all.select { |record| record.created_at == date }
  end

  def find_all_by_updated_at(date)
    all.select { |record| record.updated_at == date }
  end
end
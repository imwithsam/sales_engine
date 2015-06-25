require 'date'

class Repository
  attr_accessor :all,
                :engine

  def initialize(all_records, engine)
    self.all = all_records.map do |record|
      record_type.new(record.to_hash, self)
    end
    self.engine = engine
  end

  def inspect
    "#<#{self.class} #{self.record_type.size} rows>"
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

  def format_date_time(date_time)
    date_time.strftime("%Y-%m-%d %H:%M:%S UTC")
  end

  def next_unused_id
    all.max_by(&:id).id + 1
  end
end
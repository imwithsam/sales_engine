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
    # Do NOT memoize
    all.sample
  end
  
  def find_by_id(id)
    @find_by_id ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.id == key }
    end
    @find_by_id[id]
  end

  def find_by_created_at(date)
    @find_by_created_at ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.created_at == key }
    end
    @find_by_created_at[date]
  end

  def find_by_updated_at(date)
    @find_by_updated_at ||= Hash.new do |h, key|
      h[key] = all.detect { |record| record.updated_at == key }
    end
    @find_by_updated_at[date]
  end

  def find_all_by_id(id)
    @find_all_by_id ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.id == key }
    end
    @find_all_by_id[id]
  end

  def find_all_by_created_at(date)
    @find_all_by_created_at ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.created_at == key }
    end
    @find_all_by_created_at[date]
  end

  def find_all_by_updated_at(date)
    @find_all_by_updated_at ||= Hash.new do |h, key|
      h[key] = all.select { |record| record.updated_at == key }
    end
    @find_all_by_updated_at[date]
  end

  def format_date_time(date_time)
    @format_date_time ||= Hash.new do |h, key|
      h[key] = key.strftime("%Y-%m-%d %H:%M:%S UTC")
    end
    @format_date_time[date_time]
  end

  def next_unused_id
    return @next_unused_id if defined? @next_unused_id
    @next_unused_id = all.max_by(&:id).id + 1
  end
end
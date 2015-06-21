require 'csv'

class CsvReader
  def self.read(file_name)
    if File.exist?(file_name)
      csv = CSV.open(file_name, headers:true, header_converters: :symbol)

      csv.to_a.reject{|row| row.empty?}.map do |row|
        row
      end
    else
      nil
    end
  end
end

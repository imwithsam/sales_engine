require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/csv_reader'

class CsvReaderTest < Minitest::Test

  def test_if_file_does_not_exist_returns_nil
    #maybe add message to say that the file does not exist
    reader = CsvReader.new
    assert_equal nil, reader.file_read('./data/test_data/made_up_file.csv')
  end

  def test_if_the_file_is_empty_returns_empty_array
    reader = CsvReader.new
    assert_equal [], reader.file_read('./data/test_data/empty_file.csv')
  end

  def test_if_header_only_no_content
    reader = CsvReader.new
    assert_equal [], reader.file_read('./data/test_data/header_no_data_test.csv')
  end

  def test_if_file_contains_one_row_returns_array_with_one_hash
    reader = CsvReader.new
    expected = [{id: "1", name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-04-29 12:22:12 UTC"}]
    assert_equal expected, reader.file_read('./data/test_data/single_merchant_test.csv')
  end

  def test_if_file_contains_more_than_one_row_returns_array_with_multiple_hashes
    reader = CsvReader.new
    expected = [{id: "1", name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-04-29 12:22:12 UTC"},
                {id: "2", name: "Klein, Rempel and Jones", created_at: "2014-02-04 10:21:16 UTC", updated_at: "2014-02-05 18:01:32 UTC"},
                {id: "3", name: "Willms and Sons", created_at: "2014-02-04 10:21:16 UTC", updated_at: "2014-02-05 18:01:32 UTC"}]
    assert_equal expected, reader.file_read('./data/test_data/merchants_test.csv')
  end

  def test_ignores_blank_line
    reader = CsvReader.new
    expected = [{id: "1", name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-04-29 12:22:12 UTC"},
                {id: "2", name: "Klein, Rempel and Jones", created_at: "2014-02-04 10:21:16 UTC", updated_at: "2014-02-05 18:01:32 UTC"},
                {id: "3", name: "Willms and Sons", created_at: "2014-02-04 10:21:16 UTC", updated_at: "2014-02-05 18:01:32 UTC"}]
    assert_equal expected, reader.file_read('./data/test_data/file_w_some_blank_lines.csv')
  end

  # def test_if_file_contains_bad_data_returns_nil
  #   reader = CsvReader.new
  #   assert_equal nil, reader.file_read('./data/test_data/bad_csv_file_test.csv')
  # end
end

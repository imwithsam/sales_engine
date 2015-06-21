# require 'minitest/autorun'
# require 'minitest/pride'
# require_relative '../lib/merchant_parser'
#
# class MerchantParserTest < Minitest::Test
#
#   def test_creates_one_new_merchant
#     parser = MerchantParser.new(self)
#     result = parser.parse('./data/test_data/single_merchant_test.csv')
#     assert_equal 1, result.count
#     assert_equal 1, result[0].id
#     assert_equal "Schroeder-Jerde", result[0].name
#     assert_equal "2012-03-27 14:53:59 UTC", result[0].created_at
#     assert_equal "2012-04-29 12:22:12 UTC", result[0].updated_at
#   end
#
#   def test_creates_multiple_merchants
#     parser = MerchantParser.new(self)
#     result = parser.parse('./data/test_data/merchants_test.csv')
#     assert_equal 3, result.count
#     assert_equal 1, result[0].id
#     assert_equal "Schroeder-Jerde", result[0].name
#     assert_equal "2012-03-27 14:53:59 UTC", result[0].created_at
#     assert_equal "2012-04-29 12:22:12 UTC", result[0].updated_at
#     assert_equal 2, result[1].id
#     assert_equal "Klein, Rempel and Jones", result[1].name
#     assert_equal "2014-02-04 10:21:16 UTC", result[1].created_at
#     assert_equal "2014-02-05 18:01:32 UTC", result[1].updated_at
#     assert_equal 3, result[2].id
#     assert_equal "Willms and Sons", result[2].name
#     assert_equal "2014-02-04 10:21:16 UTC", result[2].created_at
#     assert_equal "2014-02-05 18:01:32 UTC", result[2].updated_at
#   end
#
#   def test_handles_mechants_w_same_id
#     skip
#   end
#
#
# end
#
#

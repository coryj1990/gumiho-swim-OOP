require 'test_helper'
require 'pry'

class CompeteSQLTest < Minitest::Test

	def setup
		super

		@objtime = CompeteSQL.new("Ricky Bobby", "50 Freestyle", 400.2)
		@objtime2 = CompeteSQL.new("Kenny Loggins", "50 Freestyle", 450.88)

	end

	def test_if_times_updated

		assert_kind_of Object, @objtime

	end


end
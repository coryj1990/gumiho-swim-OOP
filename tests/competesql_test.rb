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

	def test_event_results

		@eventresults = CompeteSQL.find_event_results("50 Freestyle")

		assert_equal @eventresults[0]['TIMES'], @objtime.time
		assert_equal @eventresults[1]['TIMES'], @objtime2.time

	end


end
require 'test_helper'
require 'pry'

class CompeteSQLTest < Minitest::Test


	def setup
		super

		@objtime = CompeteSQL.new("Ricky Bobby", "50 Freestyle", 500.2)
		@objtime2 = CompeteSQL.new("Kenny Loggins", "50 Freestyle", 450.88)

	end

	def test_event_results_ordered

		@eventresults = CompeteSQL.find_event_results_ordered("50FRE")
		@noresults = CompeteSQL.find_event_results_ordered("100BU")

		assert_equal @eventresults[0]['TIMES'], @objtime2.time
		assert_equal @eventresults[1]['TIMES'], @objtime.time
		assert_operator @eventresults[0]['TIMES'], :< , @eventresults[1]['TIMES']

	end





end
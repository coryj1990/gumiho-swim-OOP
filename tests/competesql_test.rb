require 'test_helper'
require 'pry'

class CompeteSQLTest < Minitest::Test


	def setup
		super

		@objtime = CompeteSQL.new("Ricky Bobby", "50 Freestyle", 400.2)
		@objtime2 = CompeteSQL.new("Kenny Loggins", "50 Freestyle", 450.88)

	end

	def test_event_results_ordered

		@eventresults = CompeteSQL.select_from_where("*", "COMPETEINFO", "EVENTID", EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", "50 Freestyle")[0]['EVENTABV'])
		@noresults = CompeteSQL.select_from_where("*", "COMPETEINFO", "EVENTID", EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", "100 Backstroke")[0]['EVENTABV'])

		assert_equal @eventresults[0]['TIMES'], @objtime.time
		assert_equal @eventresults[1]['TIMES'], @objtime2.time
		assert_operator @eventresults[0]['TIMES'], :< , @eventresults[1]['TIMES']

	end





end
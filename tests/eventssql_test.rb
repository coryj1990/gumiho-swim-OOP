require 'test_helper'
require 'pry'

class EventsSQLTest < Minitest::Test

	def test_get_event_name

		assert_equal EventsSQL.get_event_name("1650F"), "1650 Freestyle"
		refute_equal EventsSQL.get_event_name("200BA"), "100 Backstroke"

	end

	def test_get_event_abv

		assert_equal EventsSQL.get_event_abv("1650 Freestyle"), "1650F"
		refute_equal EventsSQL.get_event_abv("200 Backstroke"), "200BU"

	end








end
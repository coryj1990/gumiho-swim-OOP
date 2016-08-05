require 'test_helper'
require 'pry'

class EventsSQLTest < Minitest::Test

	def setup
		super
		# Eventually have to do a test to delete an event and couldn't use one that other tests depended on
		# A made up event is created here to be used just for the delete test.
		DB.execute("INSERT INTO EVENTS (EVENTABV, EVENTNAME) VALUES ((\"123BB\"),(\"Made Up Event\"))")

	end	

	def test_get_event_name

		assert_equal EventsSQL.select_from_where("EVENTNAME", "EVENTS", "EVENTABV", "1650F")[0]['EVENTNAME'], "1650 Freestyle"
		refute_equal EventsSQL.select_from_where("EVENTNAME", "EVENTS", "EVENTABV", "200BA")[0]['EVENTNAME'], "100 Backstroke"

	end

	def test_get_event_abv

		assert_equal EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", "1650 Freestyle")[0]['EVENTABV'], "1650F"
		refute_equal EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", "200 Backstroke")[0]['EVENTABV'], "200BU"

	end

# 	def test_add_event

# 		@neweventname = "1000 hellstroke"
# 		@neweventabv = "HELL"

# 		EventsSQL.add_new_event(@neweventname, @neweventabv)

# 		assert_equal EventsSQL.get_event_name(@neweventabv), @neweventname
# 		assert_equal EventsSQL.get_event_abv(@neweventname), @neweventabv

# 	end

# 	def test_delete_event

# 		EventsSQL.delete_event_by_name("Made up Event")

# 		refute_includes EventsSQL.get_event, "Made up Event"
# 	end




end
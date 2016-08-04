require 'pry'

# This file contains all functions needed to manage EVENTS table in database

class EventsSQL

	attr_accessor :eventabv, :eventname

	# These get_event functions will take an abbreviation or name, and returns its other type.

	def self.get_event_name(eventabv)

		return DB.execute("SELECT EVENTNAME FROM EVENTS WHERE EVENTABV = \"#{eventabv}\"")[0]['EVENTNAME']

	end

	def self.get_event_abv(eventname)

		return DB.execute("SELECT EVENTABV FROM EVENTS WHERE EVENTNAME = \"#{eventname}\"")[0]['EVENTABV']

	end

	### IN THE CASE WHERE EVENTS NEED TO BE ADDED OR DELETED use these below.
	### NEVER should they appear within code dealing with swimmeet info
	# returns nothing!

	def self.add_new_event(eventname, eventabv)

		DB.execute("INSERT INTO EVENTS (EVENTABV, EVENTNAME) VALUES ((\"#{eventabv}\"),(\"#{eventname}\"))")

	end

	def self.delete_event_by_name(eventname)

		DB.execute("DELETE FROM EVENTS WHERE EVENTNAME = \"#{eventname}\"")

	end



end
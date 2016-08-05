require 'pry'
require_relative 'ORMsql.rb'

# This file contains all functions needed to manage EVENTS table in database

class EventsSQL

	extend Orm

	attr_accessor :eventabv, :eventname

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
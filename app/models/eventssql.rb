require 'pry'
require_relative 'ORMsql.rb'

# This file contains all functions needed to manage EVENTS table in database

class EventsSQL

	extend Orm

	### IN THE CASE WHERE EVENTS NEED TO BE ADDED OR DELETED use these below.
	### NEVER should they appear within code dealing with swimmeet info
	# returns nothing!

	def self.add_new_event(eventname, eventabv)

		DB.execute("INSERT INTO EVENTS (EVENTABV, EVENTNAME) VALUES ((\"#{eventabv}\"),(\"#{eventname}\"))")

	end

	def self.delete_event_by_name(eventname)

		DB.execute("DELETE FROM EVENTS WHERE EVENTNAME = \"#{eventname}\"")

	end

	def self.paramstoDB(theparams)

	times = []

	theparams.keys.each do |key|
		if key.include? "-time" 
			times << {key => theparams[key]} 
		end
	end 

	str1 = ""
	event2 = theparams['event']

	times.each do |time|
		# Had to use double quotes below to make line breaks not an issue.
		theiD = time.keys # each run will make theiD equal the key (from times) of the loop
		theiDtime = time[theiD[0]] #getting the time from the key
		theiD = theiD[0].chomp("-time") #makes the key the number

		namer = DB.execute("SELECT NAME FROM ATHLETES WHERE ATHLETEID = \"#{theiD}\"")
		binding.pry
		CompeteSQL.new(namer[0]['NAME'], event2, theiDtime)

		end
		
	end



end



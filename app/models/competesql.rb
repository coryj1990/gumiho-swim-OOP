require 'pry'
require_relative 'ORMsql.rb'


# This class is used when submitting event results. Calling a new instance will take
# name of athlete, event, and the athlete's time and updates the database with the time.

class CompeteSQL

	extend Orm

	attr_accessor :name, :time, :rowid, :recordathid

	def initialize(name, eventname, time)

		@time = time
		@recordathid = DB.execute("SELECT ATHLETEID FROM ATHLETES WHERE NAME = \"#{name}\"")[0]['ATHLETEID']
		@theevent = DB.execute("SELECT EVENTABV FROM EVENTS WHERE EVENTNAME = \"#{eventname}\"")[0]['EVENTABV']
		@rowid = DB.execute("SELECT ROWID FROM COMPETEINFO WHERE ATHLETEID = #{@recordathid} AND EVENTID = \"#{@theevent}\"")[0]['ROWID']

		DB.execute("UPDATE COMPETEINFO SET TIMES = #{time} WHERE (ROWID) = #{@rowid}")

	end

	# When it comes to getting an ordered list of results for an event, this function will
	# take the eventid as its constraint.
	#
	# Returns array with hashes in each element. The first element contains the first place time.

	def self.find_event_results_ordered(eventid)

		return DB.execute("SELECT * FROM COMPETEINFO WHERE EVENTID = \"#{eventid}\" ORDER BY TIMES ASC")

	end


end

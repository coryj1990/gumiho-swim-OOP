require 'pry'
require_relative 'ORMsql.rb'

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

	def self.find_event_results_ordered(eventname)

		return DB.execute("SELECT * FROM COMPETEINFO WHERE EVENTID = \"#{EventsSQL.get_event_abv(eventname)}\" ORDER BY TIMES ASC")

	end


end

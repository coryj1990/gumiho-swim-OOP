require 'pry'


class CompeteSQL

	attr_accessor :name, :time

	def initialize(name, eventname, time)

		@recordsid = DB.execute("SELECT ATHLETEID FROM ATHLETES WHERE NAME = \"#{name}\"")
		@theevent = DB.execute("SELECT EVENTABV FROM EVENTS WHERE EVENTNAME = \"#{eventname}\"")

		@therecordrow = DB.execute("SELECT ROWID FROM COMPETEINFO WHERE ATHLETEID = #{@recordsid} AND EVENTID = \"#{@theevent}\"")

		DB.execute("UPDATE COMPETEINFO SET TIMES = #{time} WHERE (ROWID) = #{@therecordrow}")

	end


end
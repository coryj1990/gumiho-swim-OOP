require 'test_helper'
require 'pry'

class EntryformSQLTest < Minitest::Test

	def setup
		super

		DB.execute("DROP TABLE IF EXISTS ATHLETES")
		DB.execute("DROP TABLE IF EXISTS COMPETEINFO")
		DB.execute("CREATE TABLE IF NOT EXISTS ATHLETES (ATHLETEID INTEGER PRIMARY KEY, COLLEGE TEXT, CONF TEXT, ADDRESS TEXT, NAME TEXT)")
		DB.execute("CREATE TABLE IF NOT EXISTS COMPETEINFO (ROWID INTEGER PRIMARY KEY, ATHLETEID INTEGER, EVENTID TEXT, TIMES REAL)")

		@objname = EntryformSQL.new("Ricky Bobby", "UNO", "Omaha, NE", "100 Backstroke, 200 Breaststroke, 50 Freestyle, 200 Freestyle, 100 Butterfly")
		@objname2 = EntryformSQL.new("Kenny Loggins", "UAZ", "Tempe, AZ", "200 Butterfly, 50 Freestyle, 200 Freestyle, 1650 Freestyle, 100 Breaststroke")

	end

	def test_object_created

		assert_kind_of Object, @objname
	end

	def test_athlete_table_if_entered

		assert_equal DB.execute("SELECT NAME FROM ATHLETES WHERE ATHLETEID = \"#{@objname.id}\"")[0]['NAME'], @objname.name
		assert_equal DB.execute("SELECT ADDRESS FROM ATHLETES WHERE ATHLETEID = \"#{@objname.id}\"")[0]['ADDRESS'], @objname.address
		assert_equal DB.execute("SELECT COLLEGE FROM ATHLETES WHERE ATHLETEID = \"#{@objname.id}\"")[0]['COLLEGE'], @objname.college

	end

	def test_competeinfo_table_if_entered_matches

		n = 0
		while n < @objname.eventsarr.size
			assert_equal DB.execute("SELECT ATHLETEID FROM COMPETEINFO WHERE EVENTID = (SELECT EVENTABV FROM EVENTS WHERE EVENTNAME = \"#{@objname.eventsarr[n]}\")")[0]['ATHLETEID'], @objname.id
			assert_equal DB.execute("SELECT EVENTID FROM COMPETEINFO WHERE ATHLETEID = #{@objname.id}")[n]['EVENTID'], DB.execute("SELECT EVENTABV FROM EVENTS WHERE EVENTNAME = \"#{@objname.eventsarr[n]}\"")[0]['EVENTABV']
			n += 1
		end

	end

		


end



require 'test_helper'
require 'pry'

class EntryformSQLTest < Minitest::Test

	def setup
		super

		DB.execute("DROP TABLE IF EXISTS ATHLETES")
		DB.execute("DROP TABLE IF EXISTS EVENTS")
		DB.execute("DROP TABLE IF EXISTS COMPETEINTO")
		DB.execute("CREATE TABLE ATHLETES (ATHLETEID INTEGER PRIMARY KEY, COLLEGE TEXT, CONF TEXT, ADDRESS TEXT, NAME TEXT)")
		DB.execute("CREATE TABLE IF NOT EXISTS EVENTS (ROWID INTEGER PRIMARY KEY, EVENTABV TEXT, EVENTNAME TEXT)")
		DB.execute("CREATE TABLE IF NOT EXISTS COMPETEINFO (ROWID INTEGER PRIMARY KEY, ATHLETEID INTEGER, EVENTID TEXT, TIMES REAL)")

		eventarr = ['1650F', '200FR', '100BA', '100BR', '200BU', '50FRE', '100FR', '200BA', '200BR', '500FR', '100BU', '400IM']
		eventnames = ['1650 Freestyle', '200 Freestyle', '100 Backstroke', '100 Breaststroke', '200 Butterfly', '50 Freestyle', '100 Freestyle', '200 Backstroke', '200 Breaststroke', '500 Freestyle', '100 Butterfly', '400 Individual Medley']
		i = 0

		while i < eventarr.size
			DB.execute("INSERT INTO EVENTS (EVENTABV, EVENTNAME) VALUES (?, ?)", [eventarr[i].chomp], eventnames[i])
			i += 1
		end

		@objname = EntryformSQL.new("Ricky Bobby", "UNO", "Omaha, NE", "100 Backstroke, 200 Breaststroke")

	end

	def test_object_created

		assert_kind_of Object, @objname
	end

	def test_athlete_table_if_entered

		assert_equal DB.execute("SELECT NAME FROM ATHLETES WHERE ATHLETEID = 1")[0]['NAME'], @objname.name
		assert_equal DB.execute("SELECT ADDRESS FROM ATHLETES WHERE ATHLETEID = 1")[0]['ADDRESS'], @objname.address
		assert_equal DB.execute("SELECT COLLEGE FROM ATHLETES WHERE ATHLETEID = 1")[0]['COLLEGE'], @objname.college

	end

	def test_competeinfo_table_if_entered

		n = 0
		binding.pry
		while n < DB.execute("SELECT ATHLETEID FROM COMPETEINFO").size
			assert_equal DB.execute("SELECT ATHLETEID FROM COMPETEINFO")[n]['ATHLETEID'], DB.execute("SELECT NAME FROM ATHLETES WHERE ATHLETEID = 1")[0]['NAME']
			n += 1
		end

	end


end



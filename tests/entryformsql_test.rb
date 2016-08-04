require 'test_helper'
require 'pry'

class EntryformSQLTest < Minitest::Test

	def setup
		super
		# initially two athletes will be put into test.db
		#
		# The below executions makes sure there are no present data inside any tables.
		# The tables we are working with are ATHLETES, EVENTS, and COMPETEINFO
		# ATHLETES is compsed of ATHLETEID, NAME, ADDRESS, COLLEGE, CONF
		#
		# EVENTS is a static table (only needed to make it once) and serves the purpose of matching
		# EVENTABV to the EVENTNAME
		#
		# COMPETEINFO IS MADE UP OF ROWID, ATHLETEID, EVENTID, AND TIMES. ATHLETE ID and EVENTID
		# can already be put into COMPETEINFO. TIMES will be updated later when our so called
		# swimmeet will start (because at this stage we are just entering athletes, meet hasn't begun).
		DB.execute("DROP TABLE IF EXISTS ATHLETES")
		DB.execute("DROP TABLE IF EXISTS COMPETEINFO")
		DB.execute("CREATE TABLE IF NOT EXISTS ATHLETES (ATHLETEID INTEGER PRIMARY KEY, COLLEGE TEXT, CONF TEXT, ADDRESS TEXT, NAME TEXT)")
		DB.execute("CREATE TABLE IF NOT EXISTS COMPETEINFO (ROWID INTEGER PRIMARY KEY, ATHLETEID INTEGER, EVENTID TEXT, TIMES REAL)")

		@objname = EntryformSQL.new("Ricky Bobby", "UNO", "Omaha, NE", "100 Backstroke, 200 Breaststroke, 50 Freestyle, 200 Freestyle, 100 Butterfly")
		@objname2 = EntryformSQL.new("Kenny Loggins", "UAZ", "Tempe, AZ", "200 Butterfly, 50 Freestyle, 200 Freestyle, 1650 Freestyle, 100 Breaststroke")

	end

	def test_object_created
		# Just to see if it truely is an object
		assert_kind_of Object, @objname
	end

	def test_athlete_table_if_entered
		# Just to see if entered data matches find_by_id function
		assert_equal EntryformSQL.find_by_id(@objname.id)[0]['NAME'], @objname.name
		assert_equal EntryformSQL.find_by_id(@objname.id)[0]['ADDRESS'], @objname.address
		assert_equal EntryformSQL.find_by_id(@objname.id)[0]['COLLEGE'], @objname.college

	end

	def test_competeinfo_table_if_entered_matches
		# have yet to start on competeinfosql.rb or eventssql.rb to make ORM functions, but the execute 
		# commands will take the array of events the athlete is in, loops through that array 
		# and checks to see if there is a matching record in COMPETEINFO with athleteid and eventid
		n = 0
		while n < @objname.eventsarr.size
			assert_equal DB.execute("SELECT ATHLETEID FROM COMPETEINFO WHERE EVENTID = (SELECT EVENTABV FROM EVENTS WHERE EVENTNAME = \"#{@objname.eventsarr[n]}\")")[0]['ATHLETEID'], @objname.id
			assert_equal DB.execute("SELECT EVENTID FROM COMPETEINFO WHERE ATHLETEID = #{@objname.id}")[n]['EVENTID'], DB.execute("SELECT EVENTABV FROM EVENTS WHERE EVENTNAME = \"#{@objname.eventsarr[n]}\"")[0]['EVENTABV']
			n += 1
		end

	end

	def test_found_obj_by_id
		# checks if object made by using .find_by_id matches the instance information

		assert_equal EntryformSQL.find_by_id(@objname.id)[0]['ATHLETEID'], @objname.id
		assert_equal EntryformSQL.find_by_id(@objname.id)[0]['NAME'], @objname.name
		assert_equal EntryformSQL.find_by_id(@objname.id)[0]['COLLEGE'], @objname.college
		assert_equal EntryformSQL.find_by_id(@objname.id)[0]['ADDRESS'], @objname.address
		assert_equal EntryformSQL.find_by_id(@objname2.id)[0]['ATHLETEID'], @objname2.id

	end

	def test_found_obj_by_name
		# checks if .find_by_name works the same way 

		assert_equal EntryformSQL.find_by_name(@objname.name)[0]['NAME'], @objname.name
		assert_equal EntryformSQL.find_by_name(@objname2.name)[0]['NAME'], @objname2.name

	end
	
	def test_update_obj_name_and_college
		# tests to see if initial info is changed (or not) after updating athlete record

		origname = @objname.name
		origid = @objname.id
		origcollege = @objname.college
		origaddr = @objname.address

		EntryformSQL.update_record_by_id(1, "Billy Bob", "University of Pheonix", "Pheonix, AZ", "100 Freestyle, 200 Freestyle, 400 Intermediate Medley")

		refute_equal origname, EntryformSQL.find_by_id(origid)[0]['NAME']
		refute_equal origcollege, EntryformSQL.find_by_id(origid)[0]['COLLEGE']
		assert_equal origid, EntryformSQL.find_by_id(origid)[0]['ATHLETEID']
		refute_equal @objname.address, EntryformSQL.find_by_id(origid)[0]['ADDRESS']

	end

	def test_update_obj_by_name
		# Similarly, made function to update record by name, because I would not expect our swimmeet 
		# coordinator to base every edit off of the ID. Maybe they at first have the thought "I need to
		# update Kenny's record" instead of "I need to update number 1's record".

		origid = @objname2.id
		origcollege = @objname2.college
		origaddr = @objname2.address

		EntryformSQL.update_record_by_name("Kenny Loggins", "Richards University", "Boston, MA", "50 Freestyle, 100 Breaststroke, 100 Butterfly")

		refute_equal EntryformSQL.find_by_id(origid)[0]['COLLEGE'], origcollege
		assert_equal EntryformSQL.find_by_id(origid)[0]['ATHLETEID'], origid
		refute_equal EntryformSQL.find_by_id(origid)[0]['ADDRESS'], origaddr

	end

	def test_delete_record_by_name
		# If an athlete were to request to not participate, or for whatever reason, this test
		# Will see if the records in ATHLETES and COMPETEINFO are deleted.

		deletedname = @objname.name
		deletedid = @objname.id
		notdeletedname = @objname2.name

		EntryformSQL.delete_record_by_name("Ricky Bobby")

		assert_empty EntryformSQL.find_by_name(deletedname)
		assert_empty DB.execute("SELECT * FROM COMPETEINFO WHERE ATHLETEID = #{deletedid}")
		refute_empty EntryformSQL.find_by_name(notdeletedname)

	end



end



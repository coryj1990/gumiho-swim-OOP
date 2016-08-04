require 'pry'
require_relative '../controllers/secretstuff.rb'
require 'HTTParty'

# This file contains all SQL class commands to manage ATHLETE and some COMPETEINFO records
# in the database

class EntryformSQL
	# attr_accessor is a combo of the reader and writer attr stuffs.
	attr_accessor :name, :college, :address, :eventstring, :eventsarr, :conf, :id

	# Copied functions from entryform models to get functions within class to work
	# These latget and eastorwest functions are all that are needed to determine
	# conference of athlete given their address of university.

	# latget takes an address. Can be full address or just city, state format
	#
	# returns latitude coordinate from google api map

	def latget(spot)
		hasher = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{spot}&key=#{API_KEY}")
		tochecklat = hasher["results"][0]["geometry"]["location"]["lng"]

		return tochecklat
	end

	# Takes an address, puts it into latget, and compares it to the latitude coordinate of the mississippi
	# 
	# Returns Eastern or Western if the address's coordinate is East or West of the mississippi

	def eastorwest(theaddr)
		if latget(theaddr) > -95.2075
			eorwarray = "Eastern"
		end
		if latget(theaddr) < -95.2075
			eorwarray = "Western"
		end

		return eorwarray
	end

	# At this state of our product, the event coordinator is entering an athlete's name, address, college,
	# as well as checking off all the events the athlete is in. *WIP: because this is testing, no
	# integration has been made to take the params passed on from the HTML forms to generate event string,
	# but there will be*
	#
	# Initialize will take all info and store them into ATHLETES and COMPETEINFO TABLE.
	#
	# returns nothing!

	def initialize (name, college, address, eventstring)
		@name = name
		@college = college
		@address = address
		@eventstring = eventstring
		@eventsarr = @eventstring.split(", ")
		@conf = eastorwest(@address)

		DB.execute("INSERT INTO ATHLETES (COLLEGE, CONF, ADDRESS, NAME) VALUES (?,?,?,?)", [@college, @conf, @address, @name])
		@id = DB.last_insert_row_id

		n = 0
		while n < @eventsarr.size
			DB.execute("INSERT INTO COMPETEINFO (EVENTID, ATHLETEID) VALUES ((SELECT EVENTABV FROM EVENTS WHERE EVENTNAME = \"#{@eventsarr[n]}\"), (SELECT ATHLETEID FROM ATHLETES WHERE NAME = \"#{@name}\"))")
			n += 1
		end

	end

	# Returns record from ATHLETES based on ID
	def self.find_by_id(id)

		return DB.execute("SELECT * FROM ATHLETES WHERE ATHLETEID = \"#{id}\"")

	end

	# Returns record from ATHLETES based on name
	def self.find_by_name(name)

		return DB.execute("SELECT * FROM ATHLETES WHERE NAME = \"#{name}\"")

	end

	# If a record needs to be updated (either just a single column, or the entire thing) supply this 
	# function with the ID, name, college, address, and events of the athlete.
	#
	# returns object with updated record info
	def self.update_record_by_id(id, name, college, address, eventstring)

		DB.execute("UPDATE ATHLETES SET NAME = \"#{name}\" WHERE ATHLETEID = #{id}")
		DB.execute("UPDATE ATHLETES SET COLLEGE = \"#{college}\" WHERE ATHLETEID = #{id}")
		DB.execute("UPDATE ATHLETES SET ADDRESS = \"#{address}\" WHERE ATHLETEID = #{id}")
		@newconf = eastorwest(address)
		DB.execute("UPDATE ATHLETES SET CONF = \"#{@newconf}\" WHERE ATHLETEID = #{id}")
		@neweventsarr = eventstring.split(", ")
		n = 0
		while n < @neweventsarr.size
			DB.execute("INSERT INTO COMPETEINFO (EVENTID, ATHLETEID) VALUES ((SELECT EVENTABV FROM EVENTS WHERE EVENTNAME = \"#{@neweventsarr[n]}\"), (SELECT ATHLETEID FROM ATHLETES WHERE NAME = \"#{name}\"))")
			n += 1
		end

		return DB.execute("SELECT * FROM ATHLETES WHERE ATHLETEID = #{id}")

	end

	# Same principle as update_record_by_id, this update function is based on the athlete's name 
	#
	# returns updated record object.
	def self.update_record_by_name(name, college, address, eventstring)

		DB.execute("UPDATE ATHLETES SET COLLEGE = \"#{college}\" WHERE NAME = \"#{name}\"")
		DB.execute("UPDATE ATHLETES SET ADDRESS = \"#{address}\" WHERE NAME = \"#{name}\"")
		@newconf = eastorwest(address)
		DB.execute("UPDATE ATHLETES SET CONF = \"#{@newconf}\" WHERE NAME = \"#{name}\"")
		@neweventsarr = eventstring.split(", ")
		n = 0
		while n < @neweventsarr.size
			DB.execute("INSERT INTO COMPETEINFO (EVENTID, ATHLETEID) VALUES ((SELECT EVENTABV FROM EVENTS WHERE EVENTNAME = \"#{@neweventsarr[n]}\"), (SELECT ATHLETEID FROM ATHLETES WHERE NAME = \"#{name}\"))")
			n += 1
		end

		return DB.execute("SELECT * FROM ATHLETES WHERE NAME = \"#{name}\"")

	end	

	# This will delete a record from the DB associated with the name
	#
	# Returns nothing
	def self.delete_record_by_name(name)

		@idtodelete = EntryformSQL.find_by_name(name)[0]['ATHLETEID']
		DB.execute("DELETE FROM ATHLETES WHERE ATHLETEID = #{@idtodelete}")
		DB.execute("DELETE FROM COMPETEINFO WHERE ATHLETEID = #{@idtodelete}")


	end



end






























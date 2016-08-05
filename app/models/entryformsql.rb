require 'pry'
require_relative '../controllers/secretstuff.rb'
require 'HTTParty'
require_relative 'ORMsql.rb'

# This file contains all SQL class commands to manage ATHLETE and some COMPETEINFO records in the 
# EntryformSQL class, and another function after to generate the needed event string to pass into
# the class's initializer.

class EntryformSQL

	extend Orm
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


def checkIfInEvent(stuffs1650F, stuffs200FR, stuffs100BA, stuffs100BR, stuffs200BU, stuffs50FRE, stuffs100FR, stuffs200BA, stuffs200BR, stuffs500FR, stuffs100BU, stuffs400IM)
  # created a blank string for the if logics
  eventstring = ""

  # if eventstring is empty (length 0) then event string is saved as the event 
  # title. If eventstring does have an event title in it already, it will join 
  # the two strings together.
  if stuffs1650F == "on"
    if eventstring.empty? == true
      eventstring = newstring("1650 Freestyle")
    else
      eventstring = joinstrings(eventstring, "1650 Freestyle")
    end
  end
  if stuffs200FR == "on"
    if eventstring.empty? == true
      eventstring = newstring("200 Freestyle")
    else
      eventstring = joinstrings(eventstring, "200 Freestyle")
    end
  end
  if stuffs100BA == "on"
    if eventstring.empty? == true
      eventstring = newstring("100 Backstroke")
    else
      eventstring = joinstrings(eventstring, "100 Backstroke")
    end
  end
  if stuffs100BR == "on"
    if eventstring.empty? == true
      eventstring = newstring("100 Breaststroke")
    else
      eventstring = joinstrings(eventstring, "100 Breaststroke")
    end
  end
  if stuffs200BU == "on"
    if eventstring.empty? == true
      eventstring = newstring("200 Butterfly")
    else
      eventstring = joinstrings(eventstring, "200 Butterfly")
    end
  end
  if stuffs50FRE == "on"
    if eventstring.empty? == true
      eventstring = newstring("50 Freestyle")
    else
      eventstring = joinstrings(eventstring, "50 Freestyle")
    end
  end
  if stuffs100FR == "on"
    if eventstring.empty? == true
      eventstring = newstring("100 Freestyle")
    else
      eventstring = joinstrings(eventstring, "100 Freestyle")
    end
  end
  if stuffs200BA == "on"
    if eventstring.empty? == true
      eventstring = newstring("200 Backstroke")
    else
      eventstring = joinstrings(eventstring, "200 Backstroke")
    end
  end
  if stuffs200BR == "on"
    if eventstring.empty? == true
      eventstring = newstring("200 Breaststroke")
    else
      eventstring = joinstrings(eventstring, "200 Breaststroke")
    end
  end
  if stuffs500FR == "on"
    if eventstring.empty? == true
      eventstring = newstring("500 Freestyle")
    else
      eventstring = joinstrings(eventstring, "500 Freestyle")
    end
  end
  if stuffs100BU == "on"
    if eventstring.empty? == true
      eventstring = newstring("100 Butterfly")
    else
      eventstring = joinstrings(eventstring, "100 Butterfly")
    end
  end
  if stuffs400IM == "on"
    if eventstring.empty? == true
      eventstring = newstring("400 Individual Medley")
    else
      eventstring = joinstrings(eventstring, "400 Individual Medley")
    end
  end

  return eventstring
end




























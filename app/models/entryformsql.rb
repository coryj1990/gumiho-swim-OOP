require 'pry'
require_relative '../controllers/secretstuff.rb'
require 'HTTParty'


class EntryformSQL

	attr_accessor :name, :college, :address, :eventstring, :conf

	def latget(spot)
		hasher = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{spot}&key=#{API_KEY}")
		tochecklat = hasher["results"][0]["geometry"]["location"]["lng"]

		return tochecklat
	end


	def eastorwest(theaddr)
		if latget(theaddr) > -95.2075
			eorwarray = "Eastern"
		end
		if latget(theaddr) < -95.2075
			eorwarray = "Western"
		end

		return eorwarray
	end

	def initialize (name, college, address, eventstring)
		@name = name
		@college = college
		@address = address
		@eventstring = eventstring
		@eventsarr = @eventstring.split(", ")
		@conf = eastorwest(@address)

		DB.execute("INSERT INTO ATHLETES (COLLEGE, CONF, ADDRESS, NAME) VALUES (?,?,?,?)", [@college, @conf, @address, @name])

		n = 0
		while n < @eventsarr.size
			DB.execute("INSERT INTO COMPETEINFO (ATHLETEID, EVENTID) VALUES ((SELECT EVENTABV FROM EVENTS WHERE EVENTNAME = \"#{@eventsarr[n]}\"), (SELECT ATHLETEID FROM ATHLETES WHERE NAME = \"#{@name}\"))")
			n += 1
		end

	end



end






























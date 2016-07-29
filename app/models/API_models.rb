## everything needed for the API controller should be here

# addresswriter will take an address makes it compatible for geocode api
#
# Returns string with proper format needed for geocode API

require "httparty"
require_relative "../controllers/secretstuff.rb"
require "pry"
require_relative "entryform_models.rb"
require_relative "event_model.rb"
require_relative "winnerlist_model.rb"

def addresswriter(str)
	a_new_file = File.new("address.txt", "w")

	while str.index(" ") != nil
		to_plus_index = str.index(" ")
		str[to_plus_index] = "+"
	end

	a_new_file.puts str
end

def addressapp(str)
	a_new_file = File.new("address.txt", "a")

	while str.index(" ") != nil
		to_plus_index = str.index(" ")
		str[to_plus_index] = "+"
	end

	a_new_file.puts str
end


def conffromcollegearr(collegename)
	stuff = File.open("address.txt", "r")
	addrconf = []

	stuff.each_with_index do |it, index|
		addrconf[index] = it.chomp.split(", ")
	end

	confarr = []
	i = 0
	n = 0
	while i < addrconf.length
		if addrconf[i].include?(collegename.chomp)
			confarr[n] = addrconf[i][1]
			n += 1
		end

		i += 1
	end

	return confarr
end


# latget will check the array of addresses and create a new array with
# info about the conference that address is affiliated with
#
# Returns array of conference allegiance.

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


## Everything below is in relation to making an API for users to pull
# the hash from



def allinfo()
	eventsarray = readereventsfromtimes("times.txt")
	fillhash = {}

	n = 0
	while n < eventsarray.size

	entrants_in_single_event = peopleinevent(eventsarray[n], "entrants.txt")

		int = 0
		while int < entrants_in_single_event.size
			entrants_in_single_event[int] = entrants_in_single_event[int].chomp
			int += 1
		end

	fillhash[eventsarray[n]] = entrants_in_single_event
	n += 1
	end

	## At this point fillhash is a hash with keys being event titles
	# and values being an array of participants

	fillhash2 = {}
	fillhash3 = {}
	results_array = readerlistedplaces("times.txt")

	m = 0
	
	while m < eventsarray.size

		int = 0

		while int < results_array[0][m].size

			fillhash3[results_array[0][m][int]] = results_array[1][m][int].chomp
			int += 1
		end

		fillhash2[eventsarray[m]] = fillhash3
		fillhash3 = {}
		m += 1

	end

	fillhash4 = {}

	collconfarr = File.open("address.txt", "r")

	collconfarr.each do |thing|
		thing = thing.split(", ")
		fillhash4[thing[0]] = thing[1].chomp
	end

allhash = {}
allhash["Entrants in event"] = fillhash
allhash["Results of event"] = fillhash2
allhash["Conference of college"] = fillhash4

return allhash



end












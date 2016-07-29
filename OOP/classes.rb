require "pry"
require "httparty"


class Entryformobject

	def readerIDs(thefilename)
		goodies = File.open(thefilename, "a")
		goodies.close
		goodies = File.open(thefilename, "r")
		iDs = Array.new
		goodies.readlines.each_with_index do |line, index|
			if index%5 == 0
				iDs << line
			end
		end
		return iDs
	end

	def idGeneration
  		previousCompetitorId = readerIDs("entrants.txt").length

		#need to set competitorID to retrieve previous from storage (if it exists)
		competitorID = previousCompetitorId + 1

  		return competitorID.to_s
	end

	def setuID()
		@theid = idGeneration
	end

	def getuID()
		return @theid
	end

	# setuID has all necessary functions needed to make @theid
	# onto making seteventstring

	def joinstrings(str1, str2)
	  newstring = str1 << ", " << str2
	  return newstring
	end
	def newstring(str1)
	  newstring = str1
	  return newstring
	end


	def setevent(stuffs1650F, stuffs200FR, stuffs100BA, stuffs100BR, stuffs200BU, stuffs50FRE, stuffs100FR, stuffs200BA, stuffs200BR, stuffs500FR, stuffs100BU, stuffs400IM)
	    # created a blank string for the if logics
	    @eventstring = ""

	    # if eventstring is empty (length 0) then event string is saved as the event 
	    # title. If eventstring does have an event title in it already, it will join 
	    # the two strings together.
	    if stuffs1650F == "on"
	 	   if @eventstring.empty? == true
		        @eventstring = newstring("1650 Freestyle")
	        else
	        	@eventstring = joinstrings(@eventstring, "1650 Freestyle")
	    	end
	    end
	    if stuffs200FR == "on"
	    	if @eventstring.empty? == true
	      		@eventstring = newstring("200 Freestyle")
	    	else
	      		@eventstring = joinstrings(@eventstring, "200 Freestyle")
	    	end
	  	end
	  	if stuffs100BA == "on"
	    	if @eventstring.empty? == true
	      		@eventstring = newstring("100 Backstroke")
	    	else
	      		@eventstring = joinstrings(@eventstring, "100 Backstroke")
	    	end
	  	end
	  	if stuffs100BR == "on"
	    	if @eventstring.empty? == true
	      		@eventstring = newstring("100 Breaststroke")
	    	else
	      		@eventstring = joinstrings(@eventstring, "100 Breaststroke")
	    	end
	  	end
	  	if stuffs200BU == "on"
	    	if @eventstring.empty? == true
	      		@eventstring = newstring("200 Butterfly")
	    	else
	      		@eventstring = joinstrings(@eventstring, "200 Butterfly")
	    	end
	  	end
	  	if stuffs50FRE == "on"
	    	if @eventstring.empty? == true
	      		@eventstring = newstring("50 Freestyle")
	    	else
	      		@eventstring = joinstrings(@eventstring, "50 Freestyle")
	    	end
	  	end
	  	if stuffs100FR == "on"
	    	if @eventstring.empty? == true
	      		@eventstring = newstring("100 Freestyle")
	    	else
	      		@eventstring = joinstrings(@eventstring, "100 Freestyle")
	    	end
	  	end
	  	if stuffs200BA == "on"
	    	if @eventstring.empty? == true
	      		@eventstring = newstring("200 Backstroke")
	    	else
	      		@eventstring = joinstrings(@eventstring, "200 Backstroke")
	    	end
	  	end
	  	if stuffs200BR == "on"
	    	if @eventstring.empty? == true
	      		@eventstring = newstring("200 Breaststroke")
	    	else
	      		@eventstring = joinstrings(@eventstring, "200 Breaststroke")
	    	end
	  	end
	  	if stuffs500FR == "on"
	    	if @eventstring.empty? == true
	      		@eventstring = newstring("500 Freestyle")
	    	else
	      		@eventstring = joinstrings(@eventstring, "500 Freestyle")
	    	end
	  	end
	  	if stuffs100BU == "on"
	    	if @eventstring.empty? == true
	      		@eventstring = newstring("100 Butterfly")
	    	else
	      		@eventstring = joinstrings(@eventstring, "100 Butterfly")
	    	end
	  	end
	  	if stuffs400IM == "on"
	    	if @eventstring.empty? == true
	      		@eventstring = newstring("400 Individual Medley")
	    	else
	      		@eventstring = joinstrings(@eventstring, "400 Individual Medley")
	    	end
	  	end
	end

	def getevent()
		return @eventstring
	end

# So far setuID and setevent have setters made
# No need for setting names, colleges, or addresses. Those came from params.

# multiinput functions used to overwrite and append contents in 
# entrants.txt. they are written into the flatstorage as 4 lines
# as ID, athlete name, events signed up for, and college.
	def writetoentrants(uID, athlete, event, college, address)
	  newish_file = File.open("entrants.txt", "a"){}
	  newish_file.puts uID 
	  newish_file.puts athlete 
	  newish_file.puts event
	  newish_file.puts college
	  newish_file.puts address
	  newish_file.close

	end

	def latget(spot)
		hasher = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{spot}&key=#{API_KEY}")
		tochecklat = hasher["results"][0]["geometry"]["location"]["lng"]

		return tochecklat
	end


	def eastorwest(theaddr)

		if latget(theaddr) > -95.2075
			eorw = "Eastern"
		end
		if latget(theaddr) < -95.2075
			eorw = "Western"
		end

		return eorw

	end


	def writetoaddr(college, address)
	  anew_file = File.new("address.txt", "a")

	  while address.index(" ") != nil
	    to_plus_index = address.index(" ")
	    address[to_plus_index] = "+"
	  end

	  conf = eastorwest(address)

	  anew_file.puts college + ", " + conf
	  anew_file.close

	end

end


# Above class is used as such.
# x = Entryformobject.new
# x.setuID
# x.setevent(params...)
# x.writetoentrants(x.getuID, name param, x.getevent, college param, addr param)
# x.writetoaddr(college param, addr param)


class Eventpageobject < Entryformobject

	def readernames(thefilename)
		goodies = File.open(thefilename, "r")
		names = Array.new
		goodies.readlines.each_with_index do |line, index|
			if index%5 == 1
				names << line
			end
		end
		return names
	end

	def readerevents(thefilename)
		goodies = File.open(thefilename, "r")
		events = Array.new
		goodies.readlines.each_with_index do |line, index|
			if index%5 == 2
				events << line.split(", ")
			end

		end
		return events

	end

	def peopleinevent(eventname, txtfile)
		eventstuff = readerevents(txtfile)
		namestuff = readernames(txtfile)

		i = 0
		participants = Array.new
		while i < eventstuff.length
			if eventstuff[i].include?(eventname)
				participants << namestuff[i]
				i+=1
			else
				i+=1
			end
		end

		return participants	
	end

	def readercollege(thefilename)
		goodies = File.open(thefilename, "r")
		collegenames = Array.new
		goodies.readlines.each_with_index do |line, index|
			if index%5 == 3
				collegenames << line
			end
		end

		return collegenames
	end

	def collegeofperson(eventname, txtfile)
		eventstuff = readerevents(txtfile)
		collegestuff = readercollege(txtfile)

		i = 0

		thecolleges = Array.new
		while i < eventstuff.length
			if eventstuff[i].include?(eventname)
				thecolleges << collegestuff[i]
				i+=1
			else
				i+=1
			end
		end
		return thecolleges
	end

	def iDofperson(eventname, txtfile)
		eventstuff = readerevents(txtfile)
		iDstuff = readerIDs(txtfile)

		i = 0

		theiDs = Array.new

		while i < eventstuff.length
			if eventstuff[i].include?(eventname)
				theiDs << iDstuff[i]
				i += 1
			else
				i += 1
			end
		end
		return theiDs
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

	def confarrforevent(eventname, txtfile)
		n = 0
		confs = []
		while n < collegeofperson(eventname, txtfile).length

			confs[n] = conffromcollegearr(collegeofperson(eventname, txtfile)[n])
			n += 1

		end
		return confs

	end

	def writetotimes(str)
	    new_file = File.new("times.txt", "a")
	    new_file.puts str
	    new_file.close
	end


	def paramstotimes()

		theparams = params	
		times = []
		theparams.keys.each do |key|
			if key.include? "-time" 
				times << {key => theparams[key]} 
			end
		end 

		str1 = ""
		event = theparams['event']
		times.each do |time|

			# Had to use double quotes below to make line breaks not an issue.
			theiD = time.keys # each run will make theiD equal the key (from times) of the loop

			theiDtime = time[theiD[0]] #getting the time from the key

			theiD = theiD[0].chomp("\r\n-time") #makes the key the number

			str1 << (theiD << "," << theiDtime << ",") #throws all the strings together each loop
		end
		str2 = event << "," << str1.chop


		writetotimes(str2)

	end



end

# The above object is used as such
# y = Eventpageobject.new
# y.peopleinevent(eventname, txtfile) >
# y.collegeofperson(eventname, txtfile)
# y.confarrforevent(eventname, txtfile)

# And in the post controller do y.paramstotimes


class Resultpageobject < Eventpageobject

	def readereventsfromtimes(thefilename)
		moregoods = File.open(thefilename, "r")
		wholeline = Array.new
		moregoods.readlines.each do |line| # Line being "EventA, Time1, ID1, ..."
			line.chomp # Chomp gets rid of unecessary \r\n business
			wholeline << line.split(",") # split makes string into array
		end

		arrayofevents = Array.new

		j = 0
		while j < wholeline.size

			arrayofevents[j] = wholeline[j][0]
			j+=1
		end

		return arrayofevents

	end

	def readerIDs(thefilename)
		goodies = File.open(thefilename, "a")
		goodies.close
		goodies = File.open(thefilename, "r")
		iDs = Array.new
		goodies.readlines.each_with_index do |line, index|
			if index%5 == 0
				iDs << line
			end
		end
		return iDs
	end

	def collegelookbyID(txtfile, id)
		idstuff = readerIDs(txtfile)
		collegestuff = readercollege(txtfile)
		 
		idstuff.each_with_index do |chopper, index|
		    idstuff[index] = chopper.chomp
	    end
		collegestuff.each_with_index do |chopper, index|
		    collegestuff[index] = chopper.chomp
		end

		tofindcollege = idstuff.index(id)
		thecollege = collegestuff[tofindcollege]

		return thecollege
	end

	def addresslookbyID(txtfile, id)
	    idstuff = readerIDs(txtfile)
	    addressstuff = readeraddress(txtfile)
	 
	    idstuff.each_with_index do |chopper, index|
	    	idstuff[index] = chopper.chomp
	    end
	    addressstuff.each_with_index do |chopper, index|
	    	addressstuff[index] = chopper.chomp
	    end

	    tofindaddress = idstuff.index(id)
	    theaddress = addressstuff[tofindaddress]

	    return theaddress
	end

	def namelookbyID(txtfile, id)
    	idstuff = readerIDs(txtfile)
    	namestuff = readernames(txtfile)

    	idstuff.each_with_index do |chopper, index|
    		idstuff[index] = chopper.chomp
    	end
    	namestuff.each_with_index do |chopper, index|
    		namestuff[index] = chopper.chomp
    	end

    	tofindname = idstuff.index(id)
    	thename = namestuff[tofindname]

    	return thename
	end  	


	def readerlistedplaces(thefilename)
		moregoods = File.open(thefilename, "r")
		wholeline = Array.new

		moregoods.readlines.each do |line|
			line.chomp
			wholeline << line.split(",") # Similar to readerevents, wholeline
					# is array of lines from txtfile.
		end

		j=0
		while j < wholeline.size
			wholeline[j].delete_at(0) # Deletes Events from array
			j+=1
		end

		# At this point the Times and IDs are isolated in two dimentional
		# wholeline array as [[Time1, ID1, Time2, ID2], [Time1, ID1, ...],...]
		arrayoftimes = Array.new
		arrayofids = Array.new

		fillarrayids = []
		fillarraytimes = []

		wholeline.each do |stuff1| # wholeline is 2D array, stuff1 is 
							# the way to get array within array

			stuff1.each_with_index do |stuffinarr, index| 

				if index%2 == 0
					arrayofids << stuffinarr
				end
				if index%2 == 1
					arrayoftimes << stuffinarr
				end

			end

			# This loops through arrays within wholeline and every other spot
			# from wholeline is sent to two different arrays. 
			# arrayofids will collect ids (cuz they are in every 2nd spot)
			# arrayoftimes collects times at every other spot

			fillarrayids.push arrayofids
			fillarraytimes.push arrayoftimes

			# fillarray's will take those arrayofids and times and push
			# those arrays as one spot inside fillarray, creating another 
			# 2D array. ex: fillarrayids = [[arrayofids(first do loop)],
			# [arrayofids(second do loop)],...]

			arrayofids = []
			arrayoftimes = []

			# arrayofids is set to blank to be ready for next do loop
			# without this reset, fillarrays would include duplicates.
		end

		## Now that we got times seperated from IDS, we can NOW arrange times
		# from largest to smallest for the times.
		#
		# The below codage will arrange those times as such and also
		# rearranges the IDS in the same way so indexs still match.
		newarrayoftimes = []
		newarrayofids = []
		toparrayoftimes = []
		toparrayofids = []

		n = 0

		fillarraytimes.each do |stuff|

			while n < stuff.size

				idindexspot = fillarraytimes.index(stuff) 

				stuff.each_with_index do |morestuff, index|
					stuff[index] = morestuff.chomp.to_f
				end

				topspot = stuff.index(stuff.max) # Finds the highest time's index

				stuff.each_with_index do |morestuff, index|
					stuff[index] = morestuff.to_s
				end

				newarrayoftimes << stuff[topspot] # pushes highest time to newarray
				newarrayofids << fillarrayids[idindexspot][topspot] # pushes ID corresponding to highest time
				stuff[topspot] = ""
				fillarrayids[idindexspot][topspot] = ""
				n += 1
				# Had to change the loops highest time to blank spot to avoid it being used again
			end

			toparrayoftimes.push newarrayoftimes
			toparrayofids.push newarrayofids
			newarrayoftimes = []
			newarrayofids = []
			n = 0
			# toparray's are another 2D array set similary to fillarrays, but
			# they are arranged! Newarrays are reset for same purposes from above
		end

		# The results page shows three things, Name, Time, and college for each event
		# ABOVE we have assembled nice 2D arrays for IDs and Times, BELOW we 
		# do the same thing for colleges and names
		toparrayofcolleges = []
		pushingarray = []

		toparrayofids.each do |replacenames|
			replacenames.each_with_index do |names, index|
				pushingarray[index] = collegelookbyID("entrants.txt", replacenames[index])
				replacenames[index] = namelookbyID("entrants.txt", replacenames[index])


			end

			toparrayofcolleges.push pushingarray
			pushingarray = []

		end


		comboarray = []

		comboarray.push toparrayofids
		comboarray.push toparrayoftimes
		comboarray.push toparrayofcolleges

		m = 0	
		confscombo = []
		confscombopush = []

		while m < comboarray[2].length

			comboarray[2][m].each do |it|
				binding.pry
				confscombopush << conffromcollegearr(it)

			end

			confscombo.push confscombopush
			confscombopush = []

			m += 1
		end
		
		comboarray.push confscombo

		return comboarray
	end

end












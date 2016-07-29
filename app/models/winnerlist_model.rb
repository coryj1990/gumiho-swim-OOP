## Functions used to work winnerlist_controller

# From storage, readerevents will take each line in (prefferably times.txt)
# and store the entire string as an array inside a different array
# ex. "EventA, Time1, ID1, Time2, ID2, ..." is turned into
# [[EventA, Time1, ID1, Time2, ID2, ...],[EventB ...]]
# With this different array, the event title is extracted and put into 
# a final array.
#
# This final array is returned as [EventA, EventB,...]

# Takes a flatstorage file (entrants.txt) and retrieves ID and name info
# 
# Returns single name corresponding to ID
require_relative "../controllers/secretstuff.rb"
require "pry"
require_relative "entryform_models.rb"
require_relative "event_model.rb"
require "pry"

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

# Creates list of colleges
#
# returns list as array

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

# Takes flatstorage (prefferably in the format "EventA, Time1, ID1,...")
# and initially deletes the Event name from it. This is to isolate just 
# the Times, and IDs. 

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
	# do the same thing for colleges, names, and addresses.
	toparrayofcolleges = []
	toparrayofaddress = []
	pushingarray = []
	anotherpushing = []


	toparrayofids.each do |replacenames|
		replacenames.each_with_index do |names, index|
			pushingarray[index] = collegelookbyID("entrants.txt", replacenames[index])
			anotherpushing[index] = addresslookbyID("entrants.txt", replacenames[index])
			replacenames[index] = namelookbyID("entrants.txt", replacenames[index])


		end
		toparrayofcolleges.push pushingarray
		toparrayofaddress.push anotherpushing
		pushingarray = []
		anotherpushing = []
	end


comboarray = []

comboarray.push toparrayofids
comboarray.push toparrayoftimes
comboarray.push toparrayofcolleges

return comboarray

end







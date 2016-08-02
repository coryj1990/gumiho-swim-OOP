require 'sqlite3'
require 'pry'

require_relative '../app/models/entryform_models.rb'
require_relative '../app/models/event_model.rb'
require_relative '../app/models/winnerlist_model.rb'
require_relative '../app/models/API_models.rb'
require_relative '../app/controllers/secretstuff.rb'

varname = SQLite3::Database.new "swimmeet.db"
# varname.execute("DROP TABLE IF EXISTS EVENTS")
# varname.execute("CREATE TABLE EVENTS (rowid INTEGER PRIMARY KEY, EVENTABV TEXT, EVENTNAME TEXT)")

# idarr = readerIDs('../entrants.txt')
# namearr = readernames('../entrants.txt')
# collegearr = readercollege('../entrants.txt')
# addressarr = readeraddress('../entrants.txt')

# eventarr = ['1650F', '200FR', '100BA', '100BR', '200BU', '50FRE', '100FR', '200BA', '200BR', '500FR', '100BU', '400IM']
# eventnames = ['1650 Freestyle', '200 Freestyle', '100 Backstroke', '100 Breaststroke', '200 Butterfly', '50 Freestyle', '100 Freestyle', '200 Backstroke', '200 Breasttroke', '500 Freestyle', '100 Butterfly', '400 Individual Medley']
# # need to use eastorwest(addressarr[i]) for single conf call

# i = 0

# while i < eventarr.size

# 	varname.execute("INSERT INTO EVENTS (EVENTABV, EVENTNAME) VALUES (?, ?)", [eventarr[i].chomp], eventnames[i])
# 	i += 1

# end

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
			pushingarray[index] = collegelookbyID("../entrants.txt", replacenames[index])
			anotherpushing[index] = addresslookbyID("../entrants.txt", replacenames[index])
			replacenames[index] = namelookbyID("../entrants.txt", replacenames[index])


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


eventsfromtimes = readereventsfromtimes('../times.txt')
comboarray = readerlistedplaces('../times.txt')

varname.execute("DROP TABLE IF EXISTS COMPETEINFO")
varname.execute("CREATE TABLE COMPETEINFO (rowID INTEGER PRIMARY KEY, ATHLETEID INTEGER, EVENTID TEXT, TIMES INT)")

n = 0
m = 0


while n < eventsfromtimes.size
	while m < comboarray[0][n].size

		varname.execute("INSERT INTO COMPETEINFO (EVENTID) SELECT EVENTABV FROM EVENTS WHERE EVENTNAME = (?)", [eventsfromtimes[n]])
		varname.execute("INSERT INTO COMPETEINFO (ATHLETEID) SELECT ATHLETEID FROM ATHLETES WHERE NAME = (?)", [comboarray[0][n][m]])
		varname.execute("INSERT INTO COMPETEINFO (TIMES) VALUES (?)", [comboarray[1][n][m]])

		m += 1
	end
	n += 1
end























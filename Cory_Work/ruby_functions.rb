# These functions are in charge of storing event information such as 
# athlete name, the event, and college. There is a write (wri) and append
# (app) function and, for now, they are used to take moregoods.txt, delete 
# everything in it, and write/append into.

# *** Information is going to be saved as sets of four where one set 
# contains all information of an athlete when registering. An example of 
# a set is shown after all the functions are defined.

def joinstrings(str1, str2)
	newstring = str1 << ", " << str2
	return newstring
end

def multiinputapp(uID, athlete, event, college)
	newish_file = File.new("moregoods.txt", "a")
	newish_file.puts uID
	newish_file.puts athlete 
	newish_file.puts event
	newish_file.puts college
	newish_file.close

end

def multiinputwri(uID, athlete, event, college)
	newish_file = File.new("moregoods.txt", "w")
	newish_file.puts uID
	newish_file.puts athlete 
	newish_file.puts event
	newish_file.puts college
	newish_file.close

end


def reader(thefilename)
	goodies = File.open(thefilename, "r")
	puts goodies.read
end



def readernames(thefilename)
	goodies = File.open(thefilename, "r")
	names = Array.new
	goodies.readlines.each_with_index do |line, index|
		if index%4 == 1
			names << line
		end
	end
	return names
end

# line.split(", ") is used to seperate events into a single index.

def readerevents(thefilename)
	goodies = File.open(thefilename, "r")
	swim_events = Array.new
	goodies.readlines.each_with_index do |line, index|
		if index%4 ==2
			swim_events << line.split(", ")
		end

	end
	return swim_events

end

# readerevents and readernames uses return at the end to enable an expression
# like variable=readerevents('file.filetype') to have the array generated 
# inside the function saved into the variable

def readercollege(thefilename)
	goodies = File.open(thefilename, "r")
	collegenames = Array.new
	goodies.readlines.each_with_index do |line, index|
		if index%4 == 3
			collegenames << line
		end
	end
	return collegenames
	# no need for split here. Its one name per line.
end

# Some example sets that are to be written into storage	

uID1 = 001 
name1 = "Billy Bob"
event1 = "50m fly, 200 breast, 50m backstroke"
school1 = "Awesome College"

uID2 = 002
name2 = "Jilly Jones"
event2 = "200m Back, 100m fly, 50m backstroke"
school2 = "Brilliant College"

uID3 = 003
name3 = "Chris Bill"
event3 = joinstrings("50m backstroke, 100m fly", "200m fly")
school3 = "Cool School"

uID4 = 004
name4 = "Cynthia TheSwimmer"
event4 = "50m backstroke"
school4 = "Awesome College"

# the below sequence has multiinputwri first so the previous text file 
# contents is wiped and the above cases are written/appended into the txt.


# multiinputwri(uID1, name1, event1, school1)
# multiinputapp(uID2, name2, event2, school2)
# multiinputapp(uID3, name3, event3, school3)
# multiinputapp(uID4, name4, event4, school4)

# uncomment the below stuff and run this file in the terminal to see 
# results of each

# reader("moregoods.txt")
# readeruID("moregoods.txt")
# puts readernames("moregoods.txt")
# puts readerevents("moregoods.txt")
# readercollege("moregoods.txt")


# NOW THE GOOD STUFF

# Using arrays made from readerevents and readernames, a loop is done
# through eventstuff's array to search for a specific event. If an event
# matches the search, then the name of the athlete will present following
# "is in the event". This is achieved by taking advantage of the sets 
# strategy. The same index used to match the event is also the same index for
# the athlete name. 



def peopleinevent(eventname, txtfile)
	eventstuff = readerevents(txtfile)
	namestuff = readernames(txtfile)

	i = 0

	participants = Array.new
	while i < eventstuff.length
		if eventstuff[i].any? {|w| w.include? eventname}
			participants << namestuff[i]
			i+=1
		else
			i+=1
		end
	end
	return participants	
end

def readerIDs(thefilename)
	goodies = File.open(thefilename, "r")
	iDs = Array.new
	goodies.readlines.each_with_index do |line, index|
		if index%4 == 0
			iDs << line
		end
	end
	return iDs
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

thegoods = namelookbyID("../entrants.txt", "3")
puts thegoods



folks = peopleinevent("100m fly", "../entrants.txt")
puts folks










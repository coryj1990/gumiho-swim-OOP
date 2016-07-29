## All functions used in event controller should be here.

# Every reader function below will read from a file (prefferably entrants.txt)
# and selectively read from every 4th line (with different starting position
# for each funciton)
#
# The reader functions returns an array composed of either IDS, Names,
# Events, or colleges.

require "pry"

def readerIDs(thefilename)
	goodies = File.open(thefilename, "r")
	iDs = Array.new
	goodies.readlines.each_with_index do |line, index|
		if index%5 == 0
			iDs << line
		end
	end
	return iDs
end

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

def readeraddress(thefilename)
	goodies = File.open(thefilename, "r")
	addresses = Array.new
	goodies.readlines.each_with_index do |line, index|
		if index%5 == 4
			addresses << line
		end
	end

	return addresses
end



# With the ability to generate arrays of different content, but they 
# correspond with each other using the same index (all arrays will have the
# same size), the below funcitons will generate needed info to show
# people in a specific event, the college a person represents


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


def addressbycollege(collegename)
	collegestuff = readercollege("entrants.txt")
	addressstuff = readeraddress("entrants.txt")

	theaddressarray = Array.new
	i = 0

	while i < collegestuff.length
		if collegestuff[i].include?(collegename)
			theaddressarray << addressstuff[i]
			i += 1
		else
			i += 1
		end
	end
	return theaddressarray
end



# When meet coordinator submits times for each athlete for one event,
# this function will write all of those as a string. Preferable format
# for the str is event, Id1, time1, Id2, time2...

def writetotimes(str)
  new_file = File.new("times.txt", "a")
  new_file.puts str
  new_file.close
end







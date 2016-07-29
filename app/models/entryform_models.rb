
#idGeneration generates the next ID number based on the state of entrants.txt
#returns integer competitorID
def idGeneration
  previousCompetitorId = readerIDs("entrants.txt").length

	#need to set competitorID to retrieve previous from storage (if it exists)
	competitorID = previousCompetitorId + 1

  return competitorID
end

# Functions below are used below to either combine or save a new string.
def joinstrings(str1, str2)
  newstring = str1 << ", " << str2
  return newstring
end
def newstring(str1)
  newstring = str1
  return newstring
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

# multiinput functions used to overwrite and append contents in 
# entrants.txt. they are written into the flatstorage as 4 lines
# as ID, athlete name, events signed up for, and college.
def multiinputapp(uID, athlete, event, college, address)
  newish_file = File.new("entrants.txt", "a")
  newish_file.puts uID 
  newish_file.puts athlete 
  newish_file.puts event
  newish_file.puts college
  newish_file.puts address
  newish_file.close

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












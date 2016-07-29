require "pry"

MyApp.get "/entry" do
  @current_page = "Contestant"
	erb :"form/entryform"
end

MyApp.post "/swimmers/new" do
	# SO FAR the parameters posted from the entry form all have been captured
	# and saved to entrants.txt. Issues that still exist are assigning different
	# IDs to each athlete.

	# Fetching name and college of entrant
	name = params['Name']
	college = params['College']
	address = params['Address']

	# Fetching all possible params for all events. If statements below will check
	# if there is indeed a "on" ("on" is what the html checklist does if it was
	# checked) for each event ID.
	stuffs1650F = params['1650F']
	stuffs200FR = params['200FR']
	stuffs100BA = params['100BA']
	stuffs100BR = params['100BR']
	stuffs200BU = params['200BU']
	stuffs50FRE = params['50FRE']
	stuffs100FR = params['100FR']
	stuffs200BA = params['200BA']
	stuffs200BR = params['200BR']
	stuffs500FR = params['500FR']
	stuffs100BU = params['100BU']
	stuffs400IM = params['400IM']

	# String containing all of the contestant's registered events.
	eventstring = checkIfInEvent(stuffs1650F, stuffs200FR, stuffs100BA, stuffs100BR, stuffs200BU, stuffs50FRE, stuffs100FR, stuffs200BA, stuffs200BR, stuffs500FR, stuffs100BU, stuffs400IM)

	uID = idGeneration
	
	# This is where all the action happens! As these are right now, the wri and 
	# app combination are meant to first remove already existing contents in the 
	# txt file and write/append to it. The final product should have logic where
	# if the swim meet admin is just submitting their first entrant, the wri func
	# is used. For all the other applicants the app is used.
	multiinputapp(uID, name, eventstring, college, address)
	college = params['College']
	address = params['Address']
	writetoaddr(college, address)

	# Sends admin back to the entryform page
	erb :"form/entryform"
end

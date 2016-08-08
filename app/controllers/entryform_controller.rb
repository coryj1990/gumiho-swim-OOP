require "pry"
require "./OOP/classes.rb"

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

	x = Entryformobject.new
	x.setuID
	x.setevent(stuffs1650F, stuffs200FR, stuffs100BA, stuffs100BR, stuffs200BU, stuffs50FRE, stuffs100FR, stuffs200BA, stuffs200BR, stuffs500FR, stuffs100BU, stuffs400IM)
	x.writetoentrants(x.getuID, name, x.getevent, college, address)
	x.writetoaddr(college, address)

	athleteform = EntryformSQL.new(name, college, address, x.getevent)
	

	erb :"form/entryform"
end








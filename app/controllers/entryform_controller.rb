require "pry"

MyApp.get "/entry" do
  @current_page = "Contestant"
	erb :"form/entryform"
end

MyApp.post "/swimmers/new" do

	x = Entryformobject.new
	binding.pry
	x.setparams
	x.setuID
	x.setevent(x.get1650F, x.get200FR, x.get100BA, x.get100BR, x.get200BU, x.get50FRE, x.get100FR, x.get200BA, x.get200BR, x.get500FR, x.get100BU, x.get400IM)
	x.writetoentrants(x.getuID, x.getname, x.getevent, x.getcollege, x.getaddr)
	x.writetoaddr(x.getcollege, x.getaddr)
	# SO FAR the parameters posted from the entry form all have been captured
	# and saved to entrants.txt. Issues that still exist are assigning different
	# IDs to each athlete.

	# Sends admin back to the entryform page
	erb :"form/entryform"
end

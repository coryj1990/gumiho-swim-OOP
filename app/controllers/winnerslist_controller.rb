require "pry"


MyApp.get "/winners" do
	@current_page = "Winners"

	z = Resultpageobject.new
	@arraytheevents = z.readereventsfromtimes("times.txt")
	@arraycombo = z.readerlistedplaces("times.txt")

	erb :"/winnerslist"
end















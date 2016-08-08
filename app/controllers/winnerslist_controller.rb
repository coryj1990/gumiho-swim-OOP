require "pry"
require "./OOP/classes.rb"


MyApp.get "/winners" do
	@current_page = "Winners"

	z = Resultpageobject.new
	@arraytheevents = z.readereventsfromtimes("times.txt")
	@arraycombo = z.readerlistedplaces("times.txt")


	eventidarr = DB.execute("SELECT EVENTABV FROM EVENTS")

	n = 0
	@orderedeventtimes = []
	@finishedevents = []

	while n < eventidarr.size

		if CompeteSQL.find_event_results_ordered(eventidarr[n]['EVENTABV']) != []
			@orderedeventtimes << CompeteSQL.find_event_results_ordered(eventidarr[n]['EVENTABV'])
			@finishedevents << EventsSQL.select_from_where("EVENTNAME", "EVENTS", "EVENTABV", eventidarr[n]['EVENTABV'])
			n += 1
		else
			n += 1
		end

	end

	erb :"/winnerslist"
end















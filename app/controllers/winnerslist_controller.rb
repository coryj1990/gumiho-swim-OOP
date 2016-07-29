require "pry"


MyApp.get "/winners" do
	@current_page = "Winners"
	@arraytheevents = readereventsfromtimes("times.txt")
	@arraycombo = readerlistedplaces("times.txt")

	confscombo = []
	confscombopush = []

	m = 0	

	while m < @arraycombo[2].length

		@arraycombo[2][m].each do |it|
			confscombopush << conffromcollegearr(it)

		end

		confscombo.push confscombopush
		confscombopush = []

		m += 1
	end
	
	@confscombo = confscombo

	erb :"/winnerslist"
end















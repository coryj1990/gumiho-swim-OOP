require 'sqlite3'
require 'pry'

require_relative '../app/models/entryform_models.rb'
require_relative '../app/models/event_model.rb'
require_relative '../app/models/winnerlist_model.rb'
require_relative '../app/models/API_models.rb'
require_relative '../app/controllers/secretstuff.rb'

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

varname = SQLite3::Database.new "swimmeet.db"

varname.execute("CREATE TABLE ATHLETES (rowid INTEGER PRIMARY KEY, athleteid INTEGER, COLLEGE TEXT, CONF TEXT, ADDRESS TEXT, NAME TEXT);")

idarr = readerIDs('../entrants.txt')
namearr = readernames('../entrants.txt')
collegearr = readercollege('../entrants.txt')
addressarr = readeraddress('../entrants.txt')

# need to use eastorwest(addressarr[i]) for single conf call

i = 0

while i < idarr.size

	varname.execute("INSERT INTO ATHLETES (athleteid, COLLEGE, CONF, ADDRESS, NAME) VALUES(?, ?, ?, ?, ?)", [idarr[i].chomp, collegearr[i].chomp, 'temporary', addressarr[i].chomp, namearr[i].chomp])
	i += 1

end

binding.pry



# CREATE TABLE STUFF (COL1 TEXT, COL2 TEXT);
# INSERT INTO STUFF (COL1, COL2) VALUES ('c', 'd'), ('e', 'f'), ('g', 'h');
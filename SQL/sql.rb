require 'sqlite3'
require 'pry'

require_relative '../app/models/entryform_models.rb'
require_relative '../app/models/event_model.rb'
require_relative '../app/models/winnerlist_model.rb'
require_relative '../app/models/API_models.rb'
require_relative '../app/controllers/secretstuff.rb'

varname = SQLite3::Database.new "swimmeet.db"
varname.execute("DROP TABLE IF EXISTS EVENTS")
varname.execute("CREATE TABLE EVENTS (rowid INTEGER PRIMARY KEY, EVENTABV TEXT, EVENTNAME TEXT)")

idarr = readerIDs('../entrants.txt')
namearr = readernames('../entrants.txt')
collegearr = readercollege('../entrants.txt')
addressarr = readeraddress('../entrants.txt')

eventarr = ['1650F', '200FR', '100BA', '100BR', '200BU', '50FRE', '100FR', '200BA', '200BR', '500FR', '100BU', '400IM']
eventnames = ['1650 Freestyle', '200 Freestyle', '100 Backstroke', '100 Breaststroke', '200 Butterfly', '50 Freestyle', '100 Freestyle', '200 Backstroke', '200 Breasttroke', '500 Freestyle', '100 Butterfly', '400 Individual Medley']
# need to use eastorwest(addressarr[i]) for single conf call

i = 0

while i < eventarr.size

	varname.execute("INSERT INTO EVENTS (EVENTABV, EVENTNAME) VALUES (?, ?)", [eventarr[i].chomp], eventnames[i])
	i += 1

end

binding.pry



# CREATE TABLE STUFF (COL1 TEXT, COL2 TEXT);
# INSERT INTO STUFF (COL1, COL2) VALUES ('c', 'd'), ('e', 'f'), ('g', 'h');
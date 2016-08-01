require 'sqlite3'
require 'pry'

require_relative '../models/entryform_models.rb'
require_relative '../models/event_models.rb'
require_relative '../models/winnerlist_models.rb'
require_relative '../models/API_models.rb'



varname = SQLite3::Database.new "swimmeet.db"

varname.execute("CREATE TABLE ATHLETES (rowid INTEGER PRIMARY KEY, athleteid INTEGER, COLLEGE TEXT, CONF TEXT, ADDRESS TEXT, NAME TEXT);")

idarr = readerIDs('entrants.txt')
namearr = readernames('entrants.txt')
collegearr = readeraddress('entrants.txt')






CREATE TABLE STUFF (COL1 TEXT, COL2 TEXT);
INSERT INTO STUFF (COL1, COL2) VALUES ('c', 'd'), ('e', 'f'), ('g', 'h');
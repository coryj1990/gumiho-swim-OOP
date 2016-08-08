## This controller includes variables to use for any of the views pages
# The basis of these view pags is the event name,
require "pry"
require "./OOP/classes.rb"

MyApp.get "/events/1650freestyle" do

	@current_page = "1650 Freestyle"
	@theabv = EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", @current_page)[0]['EVENTABV']
	@fromDB = EntryformSQL.get_athletes_by_event(@theabv)
	y = Eventpageobject.new
	@peoplein1650F = y.peopleinevent(@current_page, "entrants.txt")
	@colleges1650F = y.collegeofperson(@current_page, "entrants.txt")
	@confs1650F = y.confarrforevent(@current_page, "entrants.txt")
	@iDs1650F = y.iDofperson(@current_page, "entrants.txt")

	erb :"events/1650freestyle"
end

MyApp.get "/events/200butterfly" do
	@current_page = "200 Butterfly"
	@theabv = EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", @current_page)[0]['EVENTABV']
	@fromDB = EntryformSQL.get_athletes_by_event(@theabv)

	y = Eventpageobject.new
	@peoplein200BU = y.peopleinevent(@current_page, "entrants.txt")
	@colleges200BU = y.collegeofperson(@current_page, "entrants.txt")
	@confs200BU = y.confarrforevent(@current_page, "entrants.txt")
	@iDs200BU = y.iDofperson(@current_page, "entrants.txt")

	erb :"events/200butterfly"
end

MyApp.get "/events/200freestyle" do
	@current_page = "200 Freestyle"
	@theabv = EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", @current_page)[0]['EVENTABV']
	@fromDB = EntryformSQL.get_athletes_by_event(@theabv)

	y = Eventpageobject.new
	@peoplein200FR = y.peopleinevent(@current_page, "entrants.txt")
	@colleges200FR = y.collegeofperson(@current_page, "entrants.txt")
	@confs200FR = y.confarrforevent(@current_page, "entrants.txt")
	@iDs200FR = y.iDofperson(@current_page, "entrants.txt")

	erb :"events/200freestyle"
end

MyApp.get "/events/100backstroke" do
	@current_page = "100 Backstroke"
	@theabv = EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", @current_page)[0]['EVENTABV']
	@fromDB = EntryformSQL.get_athletes_by_event(@theabv)

	y = Eventpageobject.new
	@peoplein100BA = y.peopleinevent(@current_page, "entrants.txt")
	@colleges100BA = y.collegeofperson(@current_page, "entrants.txt")
	@confs100BA = y.confarrforevent(@current_page, "entrants.txt")
	@iDs100BA = y.iDofperson(@current_page, "entrants.txt")

	erb :"events/100backstroke"
end

MyApp.get "/events/100breaststroke" do
	@current_page = "100 Breaststroke"
	@theabv = EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", @current_page)[0]['EVENTABV']
	@fromDB = EntryformSQL.get_athletes_by_event(@theabv)

	y = Eventpageobject.new
	@peoplein100BR = y.peopleinevent(@current_page, "entrants.txt")
	@colleges100BR = y.collegeofperson(@current_page, "entrants.txt")
	@confs100BR = y.confarrforevent(@current_page, "entrants.txt")
	@iDs100BR = y.iDofperson(@current_page, "entrants.txt")

	erb :"events/100breaststroke"
end

MyApp.get "/events/50freestyle" do
	@current_page = "50 Freestyle"
	@theabv = EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", @current_page)[0]['EVENTABV']
	@fromDB = EntryformSQL.get_athletes_by_event(@theabv)

	y = Eventpageobject.new
	@peoplein50FRE = y.peopleinevent(@current_page, "entrants.txt")
	@colleges50FRE = y.collegeofperson(@current_page, "entrants.txt")
	@confs50FRE = y.confarrforevent(@current_page, "entrants.txt")
	@iDs50FRE = y.iDofperson(@current_page, "entrants.txt")

	erb :"events/50freestyle"
end

MyApp.get "/events/100freestyle" do
	@current_page = "100 Freestyle"
	@theabv = EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", @current_page)[0]['EVENTABV']
	@fromDB = EntryformSQL.get_athletes_by_event(@theabv)

	y = Eventpageobject.new
	@peoplein100FR = y.peopleinevent(@current_page, "entrants.txt")
	@colleges100FR = y.collegeofperson(@current_page, "entrants.txt")
	@confs100FR = y.confarrforevent(@current_page, "entrants.txt")
	@iDs100FR = y.iDofperson(@current_page, "entrants.txt")

	erb :"events/100freestyle"
end

MyApp.get "/events/200backstroke" do
	@current_page = "200 Backstroke"
	@theabv = EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", @current_page)[0]['EVENTABV']
	@fromDB = EntryformSQL.get_athletes_by_event(@theabv)

	y = Eventpageobject.new
	@peoplein200BA = y.peopleinevent(@current_page, "entrants.txt")
	@colleges200BA = y.collegeofperson(@current_page, "entrants.txt")
	@confs200BA = y.confarrforevent(@current_page, "entrants.txt")
	@iDs200BA = y.iDofperson(@current_page, "entrants.txt")

	erb :"events/200backstroke"
end

MyApp.get "/events/200breaststroke" do
	@current_page = "200 Breaststroke"
	@theabv = EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", @current_page)[0]['EVENTABV']
	@fromDB = EntryformSQL.get_athletes_by_event(@theabv)

	y = Eventpageobject.new
	@peoplein200BR = y.peopleinevent(@current_page, "entrants.txt")
	@colleges200BR = y.collegeofperson(@current_page, "entrants.txt")
	@confs200BR = y.confarrforevent(@current_page, "entrants.txt")
	@iDs200BR = y.iDofperson(@current_page, "entrants.txt")

	erb :"events/200breaststroke"
end

MyApp.get "/events/500freestyle" do
	@current_page = "500 Freestyle"
	@theabv = EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", @current_page)[0]['EVENTABV']
	@fromDB = EntryformSQL.get_athletes_by_event(@theabv)

	y = Eventpageobject.new
	@peoplein500FR = y.peopleinevent(@current_page, "entrants.txt")
	@colleges500FR = y.collegeofperson(@current_page, "entrants.txt")
	@confs500FR = y.confarrforevent(@current_page, "entrants.txt")
	@iDs500FR = y.iDofperson(@current_page, "entrants.txt")

	erb :"events/500freestyle"
end

MyApp.get "/events/100butterfly" do
	@current_page = "100 Butterfly"
	@theabv = EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", @current_page)[0]['EVENTABV']
	@fromDB = EntryformSQL.get_athletes_by_event(@theabv)

	y = Eventpageobject.new
	@peoplein100BU = y.peopleinevent(@current_page, "entrants.txt")
	@colleges100BU = y.collegeofperson(@current_page, "entrants.txt")
	@confs100BU = y.confarrforevent(@current_page, "entrants.txt")
	@iDs100BU = y.iDofperson(@current_page, "entrants.txt")

	erb :"events/100butterfly"
end

MyApp.get "/events/400medley" do
	@current_page = "400 Individual Medley"
	@theabv = EventsSQL.select_from_where("EVENTABV", "EVENTS", "EVENTNAME", @current_page)[0]['EVENTABV']
	@fromDB = EntryformSQL.get_athletes_by_event(@theabv)

	y = Eventpageobject.new
	@peoplein400IM = y.peopleinevent(@current_page, "entrants.txt")
	@colleges400IM = y.collegeofperson(@current_page, "entrants.txt")
	@confs400IM = y.confarrforevent(@current_page, "entrants.txt")
	@iDs400IM = y.iDofperson(@current_page, "entrants.txt")

	erb :"events/400medley"
end

MyApp.post "/event/times" do
	binding.pry
	# params = {"event"=>"100 Backstroke", "14\r\n-time"=>"5", "16\r\n-time"=>"10", "Submit"=>"Submit"}	
	# theparams = params
	# y = Eventpageobject.new
	# y.paramstotimes(theparams)
	EventsSQL.paramstoDB(params)

erb :"home"
end















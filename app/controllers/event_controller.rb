## This controller includes variables to use for any of the views pages
# The basis of these view pags is the event name,
require "pry"

MyApp.get "/events/1650freestyle" do
	@current_page = "1650 Freestyle"

	@peoplein1650F = peopleinevent("1650 Freestyle", "entrants.txt")
	@colleges1650F = collegeofperson("1650 Freestyle", "entrants.txt")
	@iDs1650F = iDofperson("1650 Freestyle", "entrants.txt")

	n = 0
	confs1650F = []
	while n < @colleges1650F.length
		confs1650F[n] = conffromcollegearr(@colleges1650F[n])
		n += 1
	end

	@confs1650F = confs1650F

	erb :"events/1650freestyle"
end

MyApp.get "/events/200butterfly" do
	@current_page = "200 Butterfly"

	@peoplein200BU = peopleinevent("200 Butterfly", "entrants.txt")
	@colleges200BU = collegeofperson("200 Butterfly", "entrants.txt")
	@iDs200BU = iDofperson("200 Butterfly", "entrants.txt")

	n = 0
	confs200BU = []
	while n < @colleges200BU.length
		confs200BU[n] = conffromcollegearr(@colleges200BU[n])
		n += 1
	end

	@confs200BU = confs200BU
	erb :"events/200butterfly"
end

MyApp.get "/events/200freestyle" do
	@current_page = "200 Freestyle"

	@peoplein200FR = peopleinevent("200 Freestyle", "entrants.txt")
	@colleges200FR = collegeofperson("200 Freestyle", "entrants.txt")
	@iDs200FR = iDofperson("200 Freestyle", "entrants.txt")

	n = 0
	confs200FR = []
	while n < @colleges200FR.length
		confs200FR[n] = conffromcollegearr(@colleges200FR[n])
		n += 1
	end
	@confs200FR = confs200FR

	erb :"events/200freestyle"
end

MyApp.get "/events/100backstroke" do
	@current_page = "100 Backstroke"

	@peoplein100BA = peopleinevent("100 Backstroke", "entrants.txt")
	@colleges100BA = collegeofperson("100 Backstroke", "entrants.txt")
	@iDs100BA = iDofperson("100 Backstroke", "entrants.txt")

	n = 0
	confs100BA = []
	while n < @colleges100BA.length
		confs100BA[n] = conffromcollegearr(@colleges100BA[n])
		n += 1
	end
	@confs100BA = confs100BA

	erb :"events/100backstroke"
end

MyApp.get "/events/100breaststroke" do
	@current_page = "100 Breaststroke"

	@peoplein100BR = peopleinevent("100 Breaststroke", "entrants.txt")
	@colleges100BR = collegeofperson("100 Breaststroke", "entrants.txt")
	@iDs100BR = iDofperson("100 Breaststroke", "entrants.txt")

	n = 0
	confs100BR = []
	while n < @colleges100BR.length
		confs100BR[n] = conffromcollegearr(@colleges100BR[n])
		n += 1
	end
	@confs100BR = confs100BR

	erb :"events/100breaststroke"
end

MyApp.get "/events/50freestyle" do
	@current_page = "50 Freestyle"

	@peoplein50FRE = peopleinevent("50 Freestyle", "entrants.txt")
	@colleges50FRE = collegeofperson("50 Freestyle", "entrants.txt")
	@iDs50FRE = iDofperson("50 Freestyle", "entrants.txt")

	n = 0
	confs50FRE = []
	while n < @colleges50FRE.length
		confs50FRE[n] = conffromcollegearr(@colleges50FRE[n])
		n += 1
	end
	@confs50FRE = confs50FRE

	erb :"events/50freestyle"
end

MyApp.get "/events/100freestyle" do
	@current_page = "100 Freestyle"

	@peoplein100FR = peopleinevent("100 Freestyle", "entrants.txt")
	@colleges100FR = collegeofperson("100 Freestyle", "entrants.txt")
	@iDs100FR = iDofperson("100 Freestyle", "entrants.txt")

	n = 0
	confs100FR = []
	while n < @colleges100FR.length
		confs100FR[n] = conffromcollegearr(@colleges100FR[n])
		n += 1
	end
	@confs100FR = confs100FR

	erb :"events/100freestyle"
end

MyApp.get "/events/200backstroke" do
	@current_page = "200 Backstroke"

	@peoplein200BA = peopleinevent("200 Backstroke", "entrants.txt")
	@colleges200BA = collegeofperson("200 Backstroke", "entrants.txt")
	@iDs200BA = iDofperson("200 Backstroke", "entrants.txt")

	n = 0
	confs200BA = []
	while n < @colleges200BA.length
		confs200BA[n] = conffromcollegearr(@colleges200BA[n])
		n += 1
	end
	@confs200BA = confs200BA

	erb :"events/200backstroke"
end

MyApp.get "/events/200breaststroke" do
	@current_page = "200 Breaststroke"

	@peoplein200BR = peopleinevent("200 Breaststroke", "entrants.txt")
	@colleges200BR = collegeofperson("200 Breaststroke", "entrants.txt")
	@iDs200BR = iDofperson("200 Breaststroke", "entrants.txt")

	n = 0
	confs200BR = []
	while n < @colleges200BR.length
		confs200BR[n] = conffromcollegearr(@colleges200BR[n])
		n += 1
	end
	@confs200BR = confs200BR

	erb :"events/200breaststroke"
end

MyApp.get "/events/500freestyle" do
	@current_page = "500 Freestyle"

	@peoplein500FR = peopleinevent("500 Freestyle", "entrants.txt")
	@colleges500FR = collegeofperson("500 Freestyle", "entrants.txt")
	@iDs500FR = iDofperson("500 Freestyle", "entrants.txt")

	n = 0
	confs500FR = []
	while n < @colleges500FR.length
		confs500FR[n] = conffromcollegearr(@colleges500FR[n])
		n += 1
	end
	@confs500FR = confs500FR

	erb :"events/500freestyle"
end

MyApp.get "/events/100butterfly" do
	@current_page = "100 Butterfly"

	@peoplein100BU = peopleinevent("100 Butterfly", "entrants.txt")
	@colleges100BU = collegeofperson("100 Butterfly", "entrants.txt")
	@iDs100BU = iDofperson("100 Butterfly", "entrants.txt")

	n = 0
	confs100BU = []
	while n < @colleges100BU.length
		confs100BU[n] = conffromcollegearr(@colleges100BU[n])
		n += 1
	end
	@confs100BU = confs100BU

	erb :"events/100butterfly"
end

MyApp.get "/events/400medley" do
	@current_page = "400 Individual Medley"

	@peoplein400IM = peopleinevent("400 Individual Medley", "entrants.txt")
	@colleges400IM = collegeofperson("400 Individual Medley", "entrants.txt")
	@iDs400IM = iDofperson("400 Individual Medley", "entrants.txt")

	n = 0
	confs400IM = []
	while n < @colleges400IM.length
		confs400IM[n] = conffromcollegearr(@colleges400IM[n])
		n += 1
	end
	@confs400IM = confs400IM

	erb :"events/400medley"
end

MyApp.post "/event/times" do

# params = {"event"=>"100 Backstroke", "14\r\n-time"=>"5", "16\r\n-time"=>"10", "Submit"=>"Submit"}	

	times = []
	params.keys.each do |key|
		if key.include? "-time" 
			times << {key => params[key]} 
		end
	end 

	str1 = ""
	event = params['event']
	times.each do |time|

		# Had to use double quotes below to make line breaks not an issue.
		theiD = time.keys # each run will make theiD equal the key (from times) of the loop

		theiDtime = time[theiD[0]] #getting the time from the key

		theiD = theiD[0].chomp("\r\n-time") #makes the key the number

		str1 << (theiD << "," << theiDtime << ",") #throws all the strings together each loop
	end
	str2 = event << "," << str1.chop


	writetotimes(str2)
erb :"home"
end















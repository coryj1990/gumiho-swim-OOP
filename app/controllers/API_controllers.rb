## Everything API related in generating variables should be here.


MyApp.get "/API" do
@allinfo = allinfo()

return @allinfo.to_json
end






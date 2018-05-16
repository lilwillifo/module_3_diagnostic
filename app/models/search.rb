class Search < ActiveRecord::Base
  def stations
    response = conn.get("api/alt-fuel-stations/v1/nearest.json?api_key=#{ENV['API_KEY']}&location=80203&radius=6.0&fuel_type=ELEC,LPG")
    #this gives all stations in zip code, then I'll need to sort by distance, and pull top 10
    raw_stations = JSON.parse(response.body)['fuel_stations']

    sorted = raw_stations.sort_by {|station| station['distance']}
    top_10 = sorted[0..9]
  end


  def conn
    Faraday.new("https://developer.nrel.gov/")
  end

end

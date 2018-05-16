class Search < ActiveRecord::Base
  def stations
    response = conn.get("api/alt-fuel-stations/v1/nearest.json?api_key=#{ENV['API_KEY']}&location=80203&radius=6.0&fuel_type=ELEC,LPG")
    #this gives all stations in zip code, then I'll need to sort by distance, and pull top 10
    raw_stations = JSON.parse(response.body)['fuel_stations']
    sorted = raw_stations.sort_by {|station| station['distance']}
    top_10 = sorted[0..9]
    top_10.map do |raw_station|
      Station.new({   id: raw_station['id'],
                      name: raw_station['name'],
                      address: raw_station['address'],
                      fuel_type: raw_station['fuel_type'],
                      distance: raw_station['distance'],
                      access_days_time: raw_station['access_days_time']})
                end
  end


  def conn
    Faraday.new("https://developer.nrel.gov/")
  end

end

class Station
  attr_reader :id, :name, :address, :fuel_type, :distance, :access_days_time
  def initialize(data)
    @id = data['id']
    @name = data['name']
    @address = data['address']
    @fuel_type = data['fuel_type']
    @distance = data['distance']
    @access_days_time = data['access_days_time']
  end
end

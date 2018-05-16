class Search < ActiveRecord::Base
  def stations
  end
  # location=80203&radius=6.0&fuel_type=ELEC,LPG
  #this gives all stations in zip code, then I'll need to sort by distance, and pull top 10

  def conn
    Faraday.new("https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?api_key=#{ENV['API_KEY']}", headers: headers)
  end
end

require 'rails_helper'

describe 'As a user when I visit /' do
  context 'And I fill in the search form' do
    it 'I see 10 closest stations and their attributes' do
      visit '/'
      fill_in 'zip_code', with: '80203'
      click_on 'Locate'

      expect(current_path).to eq '/search'

      # Then I should see a list of the 10 closest stations
      #**within 6 miles
      # **sorted by distance
      expect(page).to have_content('10 Closest stations within 6 miles:')
      stations = Search.last.stations
      stations.each do |station|
        expect(page).to have_css(".station_#{station.id}")
      end
      # And the stations should be limited to Electric and Propane
      # And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
      stations.each do |station|
        expect(station.fuel_type).to eq('ELEC' || 'LPG')
        expect(page).to have_content(station.name)
        expect(page).to have_content(station.address)
        expect(page).to have_content(station.fuel_type)
        expect(page).to have_content(station.distance)
        expect(page).to have_content(station.access_days_time)
      end
    end
  end
end

class SearchController < ApplicationController
  def index
    search = Search.create(search_params)
    @stations = search.stations
    binding.pry
  end

  private
  def search_params
    params.permit(:zip_code)
  end
end

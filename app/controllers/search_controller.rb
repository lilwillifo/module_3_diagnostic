class SearchController < ApplicationController
  def index
    search = Search.create(search_params)
    @stations = search.stations
  end

  private
  def search_params
    params.permit(:zip_code)
  end
end

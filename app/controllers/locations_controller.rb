class LocationsController < ApplicationController
  def index
    @locations = Location.page(params[:page]).per Settings.pagination.locations_page
    @radars = Location.get_ready
    @readys = Location.get_radar
  end
end

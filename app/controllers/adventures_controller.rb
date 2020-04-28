class AdventuresController < ApplicationController
  def index
    @adventures = Adventure.geocoded  # returns Adventures with coordinates

    @markers = @adventures.map do |adventure|
      {
        lat: adventure.latitude,
        lng: adventure.longitude
      }
    end
  end
end

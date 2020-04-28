class AdventuresController < ApplicationController
  def index
    @adventures = Adventure.all

    # @adventures = Adventure.geocoded  # returns Adventures with coordinates

    # @markers = @adventures.map do |adventure|
    #   {
    #     lat: adventure.latitude,
    #     lng: adventure.longitude

    #   }
    # end
  end

  def search
    @adventures = Adventure.where(category: params["query"])
  end
end

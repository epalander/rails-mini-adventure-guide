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
    @results = Adventure.search_by_title_and_category(params["query"])
  end
end

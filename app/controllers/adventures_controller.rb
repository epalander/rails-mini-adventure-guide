class AdventuresController < ApplicationController
  def index
    @adventures = Adventure.all

    # @adventures = Adventure.geocoded  # returns Adventures with coordinates

    @markers = @adventures.map do |adventure|
      {
        lat: adventure.latitude,
        lng: adventure.longitude

      }
    end
  end

  def search
    @results = Adventure.search_by_title_and_category(params[:query])
    @params = search_params
    @results = @results.filter_by_parking if search_params[:parking] == "true"
    @results = @results.filter_by_public_transport if search_params[:public_transport] == "true"
    @results = @results.filter_by_stroller_friendly if search_params[:stroller_friendly] == "true"
    # @results = @results.filter_by_difficulty(1, 2, 3)
    # @results = @results.filter_by_youngest_age(1, 2, 3, 4, 5)
    # @results = @results.filter_by_distance(1..100)
    # @results = @results.filter_by_category('hiking trail', 'biking path')
  end

  def show
    @adventure = Adventure.find(params[:id])
  end

  def new
    @adventure = Adventure.new
  end

  def create
    @adventure = Adventure.new(adventure_params)
    if @adventure.save
      redirect_to adventure_path(@adventure)
    else
      render :new
    end
  end

  def edit
    @adventure = Adventure.find(params[:id])
  end

  def update
    @adventure = Adventure.find(params[:id])
    if @adventure.update(adventure_params)
        redirect_to adventure_path(@adventure), notice: 'Adventure was successfully updated.'
    else
      render :edit
    end
  end

  private

  def search_params
    params.permit(:query, :parking, :public_transport, :stroller_friendly, :difficulty, :youngest_age, :distance, :category)
  end

  def adventure_params
    params.require(:adventure).permit(:title, :description, :category, :distance, :stroller_friendly, :youngest_age, :difficulty, :parking, :public_transport, :directions, :address, photos: [])
  end
end

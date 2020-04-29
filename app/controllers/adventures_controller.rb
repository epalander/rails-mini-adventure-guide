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

  def adventure_params
    params.require(:adventure).permit(:title, :description, :category, :distance, :stroller_friendly, :youngest_age, :difficulty, :parking, :public_transport, :directions, :address, photos: [])
  end
end

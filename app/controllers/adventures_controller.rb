class AdventuresController < ApplicationController
  def index
    @adventures = Adventure.all
    @top_adventures = Adventure.all.first(5) #@adventures.sort_by { |a| a.avg_rating }.last(5)
    # # @adventures = Adventure.geocoded  # returns Adventures with coordinates

    @markers = @adventures.map do |adventure|
      {
        lat: adventure.latitude,
        lng: adventure.longitude
      }
    end
  end

  def search
    @results = Adventure.all
    @params = search_params
    @results = @results.search_by_title_description_and_category(search_params[:query]) if search_params[:query].present?
    @results = @results.filter_by_parking if search_params[:parking] == "true"
    @results = @results.filter_by_public_transport if search_params[:public_transport] == "true"
    @results = @results.filter_by_stroller_friendly if search_params[:stroller_friendly] == "true"
    @results = @results.filter_by_category(search_params[:category]) if search_params[:category].present?
    # @results = @results.filter_by_difficulty(1, 2, 3)
    # @results = @results.filter_by_youngest_age(1, 2, 3, 4, 5)
    # @results = @results.filter_by_distance(1..100)
    # @results = @results.filter_by_category('hiking trail', 'bike path')
  end

  def show
    @adventure = Adventure.find(params[:id])
    @age = ["under < 1 year", "1-3 years", "4-6 years", "7-11 years", "12-15 years", "16+ years"]
    @level = ["Easy", "Moderate", "Challenging"]
    @stroller = @adventure.stroller_friendly ? 'Stroller friendly' : 'Not for strollers'
    @parking = @adventure.parking ? 'Available' : 'Not available'
    @public_transport = @adventure.public_transport ? 'Available' : 'Not available'
    # @difficulty = @adventure.difficulty == "1" ? 'Easy' : (@adventure.difficulty == "2" ? "Moderate" : 'Challenging')
    @youngest_age = @age[@adventure.youngest_age - 1]
    @difficulty = @level[@adventure.difficulty - 1]

    @markers = @adventure.address
      {
        lat: @adventure.latitude,
        lng: @adventure.longitude
      }
  end

  def new
    @adventure = Adventure.new
  end

  def create
    @adventure = Adventure.new(adventure_params)
    authorize @adventure
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

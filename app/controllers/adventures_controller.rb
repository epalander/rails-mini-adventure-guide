class AdventuresController < ApplicationController
  before_action :authenticate_user!, only: :new
  def index
    @adventures = Adventure.all

    @top_adventures = @adventures.sort_by { |a| a.avg_rating }.last(5)

    @adventures_geo = Adventure.geocoded  # returns Adventures with coordinates
    # @adventures = Adventures.where.not(latitude: nil, longitude: nil)

    @markers = @adventures_geo.map do |adventure|
      {
        lat: adventure.latitude,
        lng: adventure.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { adventure: adventure }),
        image_url: helpers.asset_url('logo_smcompass1.png'),
      }
    end
  end

  def search
    @results = Adventure.all
    authorize @results
    @params = search_params
    @results = @results.search_by_title_description_address_and_category(search_params[:query]) if search_params[:query].present?
    @results = @results.filter_by_parking if search_params[:parking] == "true"
    @results = @results.filter_by_public_transport if search_params[:public_transport] == "true"
    @results = @results.filter_by_stroller_friendly if search_params[:stroller_friendly] == "true"
    @results = @results.filter_by_category(search_params[:category]) if search_params[:category].present?
    @results = @results.filter_by_avg_duration(search_params[:avg_duration]) if search_params[:avg_duration].present?
    @results = @results.filter_by_youngest_age(search_params[:youngest_age]) if search_params[:youngest_age].present?
    @results = @results.filter_by_difficulty(search_params[:difficulty]) if search_params[:difficulty].present?
    @results = @results.filter_by_distance(search_params[:distance]) if search_params[:distance].present?

    # @markers = Adventure.near([40.71, 100.23], 20)
    @markers = @results.map do |adventure|
      {
        lat: adventure.latitude,
        lng: adventure.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { adventure: adventure }),
        image_url: helpers.asset_url('logo_smcompass1.png'),
      }
    end
  end

  def show
    @adventure = Adventure.find(params[:id])

    authorize @adventure

    @avg_rating = @adventure.avg_rating

    # show right value in the icon overview on the show page
    @age = ["under < 1 year", "1-3 years", "4-6 years", "7-11 years", "12-15 years", "16+ years"]
    @level = ["Easy", "Moderate", "Challenging"]
    @stroller = @adventure.stroller_friendly ? 'Stroller friendly' : 'Not for strollers'
    @parking = @adventure.parking ? 'Available' : 'Not available'
    @public_transport = @adventure.public_transport ? 'Available' : 'Not available'
    # @difficulty = @adventure.difficulty == "1" ? 'Easy' : (@adventure.difficulty == "2" ? "Moderate" : 'Challenging')
    @youngest_age = @age[@adventure.youngest_age - 1]
    @difficulty = @level[@adventure.difficulty - 1]

    # marker for the map
    @markers = [{
      lat: @adventure.latitude,
      lng: @adventure.longitude,
      # infoWindow: render_to_string(partial: "info_window", locals: { adventure: adventure}),
      image_url: helpers.asset_url('logo_smcompass1.png')
    }]


    # newest review shown on top
    @newest_review_first = @adventure.reviews.order(created_at: :desc)

  end

  def new
    @adventure = Adventure.new
    authorize @adventure
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
    params.permit(:query, :parking, :public_transport, :stroller_friendly, :difficulty, :youngest_age, :distance, :category, :address, :avg_duration)
  end

  def adventure_params
    params.require(:adventure).permit(:title, :description, :category, :distance, :avg_duration, :stroller_friendly, :youngest_age, :difficulty, :parking, :public_transport, :directions, :address, :photo)
  end
end

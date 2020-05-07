class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update, :destroy]

  def new
    @adventure = Adventure.find(params[:adventure_id])
    @review = Review.new
    authorize @review
  end

  def create
    @adventure = Adventure.find(params[:adventure_id])
    @review = Review.new(review_params)
    authorize @review
    @review.adventure = @adventure
    @review.user = current_user

    if @review.save
      redirect_to adventure_path(@adventure), notice: "Thank you for submitting your review"
    else
      flash[:notice] = "You already left a review for this adventure."
      render :new
    end
  end

  def edit
    authorize @review
  end

  def update

    if @review.update(review_params)
      redirect_to adventure_path(@review.adventure), notice: 'Your review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @review
    @review.destroy
    redirect_to adventure_path(@review.adventure), notice: "Your review was deleted"
  end

  private

  def review_params
    params.require(:review).permit(:tagline, :content, :rating, :user_id, :adventure_id, :duration, :youngest_age, photos: [])
  end

  def set_review
    @review = Review.find(params[:id])
  end
end



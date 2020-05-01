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
      redirect_to adventures_path(@adventure), notice: "Thank you for submitting your review"
    else
      render :new
    end
  end

  # def edit
  # end

  # def update
  #   if @review.update(review_params)
  #     redirect_to adventure_path, notice: 'Your review was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    @review.destroy
    redirect_to adventures_path(@adventure), notice: "Your review was deleted"
  end

  private

  def review_params
    params.require(:review).permit(:tagline, :content, :rating, :user_id, :adventure_id)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end



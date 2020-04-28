class ReviewsController < ApplicationController

  def new
    @adventure = Adventure.find(params[:adventure_id])
    @review = Review.new
  end

  def create
    @adventure = Adventure.find(params[:adventure_id])
    @review = Review.new(review_params)
    @review.adventure = @adventure
    @review.user = current_user

    if @review.save
      redirect_to adventures_path, notice: "Thank you for submitting your review."
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:tagline, :content, :rating, :user_id, :adventure_id)
  end
end



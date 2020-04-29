class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]

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
      redirect_to adventures_path(@adventure), notice: "Thank you for submitting your review."
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

  end

  private

  def review_params
    params.require(:review).permit(:tagline, :content, :rating, :user_id, :adventure_id)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end



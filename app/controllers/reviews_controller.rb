class ReviewsController < ApplicationController
  def create
    @review = current_user.reviews.build review_params
    @review.save
    respond_to do |format|
      format.js
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :tour_id)
  end
end

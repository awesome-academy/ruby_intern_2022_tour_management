class ToursController < ApplicationController
  def show
    @tour = Tour.find params[:id]
    @pagy, @reviews = pagy @tour.reviews.includes(:user).by_created_at,
                           items: Settings.pagy.review
    @review = @tour.reviews.build if logged_in?
  end
end

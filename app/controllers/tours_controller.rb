class ToursController < ApplicationController
  load_and_authorize_resource

  def show
    @tour = Tour.find params[:id]
    @pagy, @reviews = pagy @tour.reviews.includes(:user).by_created_at,
                           items: Settings.pagy.review
    @review = @tour.reviews.build if user_signed_in?
  end
end

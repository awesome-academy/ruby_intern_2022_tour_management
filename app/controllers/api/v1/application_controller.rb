class Api::V1::ApplicationController < ApplicationController
  include Pagy::Backend

  private

  def get_tours
    @pagy, @tours = pagy Tour.includes(:tour_schedules, reviews: :user)
                             .by_id(get_tour_ids).actived(true),
                         items: Settings.pagy.tour.user.number
  end

  def get_tour_ids
    TourSchedule.get_from_current_day.pluck(:tour_id).uniq
  end
end

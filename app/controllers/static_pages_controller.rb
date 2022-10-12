class StaticPagesController < ApplicationController
  def index
    tour_ids = TourSchedule.get_from_current_day.pluck(:tour_id).uniq

    @pagy, @tours = pagy Tour.by_id(tour_ids), items:
      Settings.pagy.tour.number
  end
end

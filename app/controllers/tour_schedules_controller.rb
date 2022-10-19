class TourSchedulesController < ApplicationController
  def show
    @tour_schedules = TourSchedule.by_tour_id(params[:id])
                                  .get_from_current_day
  end
end

class TourSchedulesController < ApplicationController
  def show
    @tour_schedules = TourSchedule.by_tour_id(params[:id])
                                  .get_from_current_day

    return if @tour_schedules.present?

    flash[:danger] = t ".not_found_schedule"
  end
end

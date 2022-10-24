class BookingsController < ApplicationController
  before_action :user_logged_in

  def create
    @tour_schedule = TourSchedule.find params[:id]
    @booking = @tour_schedule.bookings.new user_id: current_user.id

    if @booking.save
      flash[:success] = t ".booking_success"
    else
      flash[:danger] = t ".booking_fail"
    end

    redirect_to booking_path
  end

  def show
    @bookings = current_user.bookings.includes(tour_schedule: :tour)
                            .order_by_status
  end
end

class BookingsController < ApplicationController
  before_action :user_logged_in
  before_action :load_booking, only: :destroy

  def create
    @tour_schedule = TourSchedule.find params[:id]
    @booking = @tour_schedule.bookings.new user_id: current_user.id

    if @booking.save
      flash[:success] = t ".booking_success"
    else
      flash[:danger] = t ".booking_fail"
    end

    redirect_to bookings_path
  end

  def show
    @bookings = current_user.bookings.includes(:tour_schedule)
                            .order_by_status
  end

  def destroy
    if @booking.pending? && @booking.destroy
      flash[:success] = t ".success_destroy"
    else
      flash[:info] = t ".not_destroy"
    end

    redirect_to bookings_path
  end
end

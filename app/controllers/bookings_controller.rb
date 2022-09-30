class BookingsController < ApplicationController
  before_action :user_logged_in

  def create
    @tour_schedule = TourSchedule.find_by id: params[:id]
    @booking = @tour_schedule.bookings.new user_id: current_user.id

    begin
      @booking.save
      flash[:success] = t ".booking_success"
    rescue StandardError
      flash[:danger] = t ".booking_fail"
    end

    redirect_to session[:return_to]
  end

  def show
    @bookings = Booking.by_user_id(current_user.id).oder_by_status

    return if @bookings.present?

    flash[:danger] = t ".error"
    redirect_to root_path
  end

  private
  def user_logged_in
    return if current_user.present?

    flash[:danger] = t ".not_logged_in"
    redirect_to login_path
  end
end

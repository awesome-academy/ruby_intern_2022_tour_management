require "./app/abilities/booking_ability"

class BookingsController < ApplicationController
  load_and_authorize_resource

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
    @pagy, @bookings = pagy current_user.bookings.includes(tour_schedule: :tour)
                                        .order_by_status,
                            items: Settings.pagy.booking.admin.number
  end

  def destroy
    if @booking.pending? && @booking.destroy
      flash[:success] = t ".success_destroy"
    else
      flash[:info] = t ".not_destroy"
    end

    redirect_to bookings_path
  end

  private

  def current_ability
    @current_ability ||= BookingAbility.new current_user
  end
end

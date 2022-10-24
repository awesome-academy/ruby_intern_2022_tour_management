class Admin::BookingsController < Admin::BaseController
  before_action :load_booking, only: :update

  def index
    @pagy, @bookings = pagy Booking.includes([:user, {tour_schedule: :tour}])
                                   .order_by_status,
                            items: Settings.pagy.booking.admin.number
  end

  def update
    @booking.status = params[:status].to_i
    if @booking.save
      SendBookingConfirmationJob.perform_async(@booking.user_id,
                                               @booking.status)
      flash[:success] = t ".success_update"
    else
      flash[:danger] = t ".fail_update"
    end
    redirect_to admin_bookings_path
  end
end

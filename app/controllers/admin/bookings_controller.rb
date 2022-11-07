class Admin::BookingsController < Admin::BaseController
  before_action :load_booking, only: :update
  before_action :load_list_booking, only: :index

  def index
    respond_to do |format|
      format.html
      format.js
    end
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

  private

  def load_list_booking
    @pagy, @bookings = pagy get_booking_by_params,
                            items: Settings.pagy.booking.admin.number
  end

  def get_booking_by_params
    Booking.includes(Booking::JOIN_TABLE)
           .by_user_name(params[:user_name])
           .by_schedule_name(params[:schedule_name])
           .by_start_date(params[:start_date])
           .by_end_date(params[:end_date])
           .by_status(params[:status])
           .order_by_status
  end
end

class Admin::BookingsController < Admin::BaseController
  load_and_authorize_resource

  before_action :load_booking, only: :update
  before_action :load_list_booking, only: :index

  def index
    if params[:chart].blank?
      respond_to do |format|
        format.html
        format.js
      end
    else
      render :chart_status
    end
  end

  def update
    @booking.status = params[:status].to_i
    if @booking.save
      flash[:success] = t ".success_update"
    else
      flash[:danger] = t ".fail_update"
    end
    redirect_to admin_bookings_path
  end

  private

  def load_list_booking
    @q = Booking.includes(:user, tour_schedule: :tour).ransack params[:q]
    @pagy, @bookings = pagy @q.result(distinct: true).order("status"),
                            items: Settings.pagy.booking.admin.number
  end
end

class Api::V1::BookingsController < Api::V1::ApplicationController
  before_action :checking_role

  def index
    @pagy, @bookings = pagy Booking.includes(:user, :tour_schedule)
                                   .order("status"),
                            items: Settings.pagy.booking.admin.number
    render json: @bookings
  end

  private

  def checking_role
    return if authenticate_request!.present?

    return if current_user&.admin?

    render json: {
      role_error: [I18n.t(".error_role")]
    }
  end
end

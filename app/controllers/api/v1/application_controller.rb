class Api::V1::ApplicationController < ActionController::API
  include Pagy::Backend

  attr_reader :current_user

  protected

  def authenticate_request!
    if user_id_in_token?
      @current_user = User.find auth_token[:user_id]
      return
    end
    render json: {errors: [I18n.t(".not_auth")]}, status: :unauthorized
  end

  private

  def get_tours
    @pagy, @tours = pagy Tour.includes(:tour_schedules, reviews: :user)
                             .by_id(get_tour_ids).actived(true),
                         items: Settings.pagy.tour.user.number
  end

  def get_tour_ids
    TourSchedule.get_from_current_day.pluck(:tour_id).uniq
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end

  def http_token
    @http_token ||= if request.headers["Authorization"].present?
                      request.headers["Authorization"].split.last
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode http_token
  end
end

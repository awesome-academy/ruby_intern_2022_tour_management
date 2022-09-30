class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :set_pagy_locale

  private

  def not_found
    flash[:danger] = t ".not_found"
    redirect_to admin_root_path if current_user&.admin?
    redirect_to root_path
  end

  def tour_params
    params.require(:tour).permit(Tour::ALLOWED_PARAMS,
                                 TourSchedule::ALLOWED_PARAMS)
  end

  def get_tours
    @pagy, @tours = pagy Tour.by_id(get_tour_ids)
                             .by_title(params[:title]).actived(true),
                         items: Settings.pagy.tour.user.number
  end

  def get_tour_ids
    TourSchedule.get_from_current_day.by_start_date(params[:start_date])
                .by_end_date(params[:end_date]).pluck(:tour_id).uniq
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def set_pagy_locale
    @pagy_locale = params[:locale]
  end

  def user_logged_in
    return if current_user.present?

    flash[:danger] = t ".not_logged_in"
    redirect_to login_path
  end
end

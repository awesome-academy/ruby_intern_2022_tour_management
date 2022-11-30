class ApplicationController < ActionController::Base
  include Pagy::Backend

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_pagy_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number])
  end

  private

  def after_sign_in_path_for _resource
    current_user.admin? ? admin_root_path : root_path
  end

  def get_root_path
    current_user&.admin? ? admin_root_path : root_path
  end

  def not_found
    flash[:danger] = t ".not_found"
    redirect_to get_root_path
  end

  def tour_params
    params.require(:tour).permit(Tour::ALLOWED_PARAMS,
                                 TourSchedule::ALLOWED_PARAMS)
  end

  def get_tours
    @q = Tour.includes(:tour_schedules).ransack params[:q]
    @pagy, @tours = pagy @q.result(distinct: true).by_id(get_tour_ids),
                         items: Settings.pagy.tour.admin.number
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
    redirect_to new_user_session_path
  end

  def load_booking
    @booking = Booking.find params[:id]
  end
end

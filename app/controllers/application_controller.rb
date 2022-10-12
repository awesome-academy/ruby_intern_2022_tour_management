class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper

  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :set_pagy_locale

  private
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
end

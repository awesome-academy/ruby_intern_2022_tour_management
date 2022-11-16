class Admin::BaseController < ApplicationController
  before_action :admin_logged_in

  layout "layouts/application_admin"

  private
  def admin_logged_in
    redirect_to root_path unless current_user&.admin?
  end
end

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase

    if user&.authenticate params.dig(:session, :password)
      log_in user
      redirect_log_in user
    else
      flash.now[:danger] = t ".unsuccess_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private
  def redirect_log_in user
    if user.admin?
      redirect_to admin_root_path
    else
      redirect_to root_path
    end
  end
end

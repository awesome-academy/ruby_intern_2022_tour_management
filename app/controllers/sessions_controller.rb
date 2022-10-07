class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase

    if user&.authenticate params.dig(:session, :password)
      log_in user
      flash[:success] = t ".success"
      redirect_to root_path
    else
      flash.now[:danger] = t ".unsuccess_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end

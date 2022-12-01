class PasswordsController < Devise::PasswordsController
  before_action :load_user_by_token, only: :update

  def update
    return if check_old_password

    return if update_password

    flash[:danger] = t ".wrong_format"
    redirect_to edit_user_password_path(
      reset_password_token: params[:user][:reset_password_token]
    )
  end

  private

  def load_user_by_token
    @user = User.with_reset_password_token params[:user][:reset_password_token]
  end

  def check_old_password
    if @user.valid_password? params[:user][:password]
      flash[:info] = t ".old_password"
      redirect_to edit_user_password_path(
        reset_password_token: params[:user][:reset_password_token]
      )
      return true
    end

    false
  end

  def update_password
    if @user.reset_password(params[:user][:password],
                            params[:user][:password_confirmation])
      flash[:success] = t ".success"
      redirect_to new_user_session_path
      return true
    end

    false
  end
end

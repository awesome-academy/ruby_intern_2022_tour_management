class Api::V1::AuthenticationController < Api::V1::ApplicationController
  def authenticate_user
    user = User.find_for_database_authentication email: params[:email]
    if user.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: {errors: [I18n.t(".invalid_auth")]},
             status: :unauthorized
    end
  end

  private

  def payload user
    return nil unless user&.id

    {
      auth_token: JsonWebToken.encode({user_id: user.id})
    }
  end
end

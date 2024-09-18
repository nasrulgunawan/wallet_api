class SessionsController < ApplicationController
  before_action :authenticate_user, only: [ :destroy ]

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = generate_token(user)
      session_token = user.session_token

      if session_token.present?
        session_token.update!(token: token)
      else
        session_token = SessionToken.create!(user: user, token: token)
      end

      render json: { message: "Logged in successfully", user_id: user.id, token: token }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    if current_user.session_token.destroy
      render json: { message: "Logged out successfully" }, status: :ok
    else
      render json: { error: "Failed to log out" }, status: :unprocessable_entity
    end
  end

  private

  def generate_token(user)
    payload = { user_id: user.id, email: user.email, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.credentials.secret_key_base, "HS256")
  end
end

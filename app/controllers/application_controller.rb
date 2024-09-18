class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def authenticate_user
    authenticate_or_request_with_http_token do |token, options|
      begin
        decoded_token = decode_token(token)
        user_id = decoded_token[0]["user_id"]
        exp = decoded_token[0]["exp"]

        if Time.now.to_i > exp
          render json: { error: "Token has expired" }, status: :unauthorized
          return
        end

        session = SessionToken.find_by(token: token, user_id: user_id)

        if session && session.user
          @current_user = session.user
        else
          render json: { error: "Invalid token" }, status: :unauthorized
        end

      rescue JWT::DecodeError
        render json: { error: "Invalid token" }, status: :unauthorized
      end
    end
  end

  def current_user
    @current_user
  end

  private

  def decode_token(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: "HS256")
  end
end

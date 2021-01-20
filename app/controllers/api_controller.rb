# frozen_string_literal: true

class ApiController < ActionController::API
  def validate_api_token
    token = request.headers[ENV['API_TOKEN_HEADER']]
    if token.nil?
      render status: 400, json: { status: 400, message: 'token does not exist' }
      return
    end
    auth = Authentication.all.find { |a| a.token == token }
    if auth.nil?
      render status: 400, json: { status: 400, message: 'token is invalid' }
      return
    end

    user = User.find(auth.user_id)
    if user.nil?
      render status: 401, json: { status: 400, message: 'user does not exist' }
      return
    end
    @current_user = user
  end
end

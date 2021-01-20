# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    expires = 2.hours.from_now
    cookies.signed[:user_id] = {
      value: user.id,
      httponly: true,
      secure: Rails.env.production?,
      expires: expires
    }
    cookies.signed[:user_token] = {
      value: user.token,
      httponly: true,
      secure: Rails.env.production?,
      expires: expires
    }
  end

  def current_user
    user = User.find_by(id: cookies.signed[:user_id])
    @current_user = user if user&.authed?(cookies.signed[:user_token])
  end

  def logged_in?
    current_user
    !@current_user.nil?
  end

  def log_out
    cookies.delete(:user_id)
    cookies.delete(:user_token)
    @current_user = nil
  end
end

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def validate_auth
    unless logged_in?
      log_out
      redirect_to(controller: :sessions, action: :new)
    end
  end

  def confirm_auth
    redirect_to(controller: :dashboard, action: :index) if logged_in?
  end
end

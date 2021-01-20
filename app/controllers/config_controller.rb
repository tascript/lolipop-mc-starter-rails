# frozen_string_literal: true

class ConfigController < ApplicationController
  layout 'dashboard'
  before_action :validate_auth

  def index
    authentication = Authentication.find_by(user_id: @current_user.id)
    unless authentication.nil?
      authentication.reload_count += 1
      authentication.save
    end
    @authentication = authentication || nil
  end

  def edit
    @user = current_user
  end
end

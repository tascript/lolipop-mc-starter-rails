# frozen_string_literal: true

class DashboardController < ApplicationController
  layout 'dashboard'
  before_action :validate_auth

  def index
    @blogs = Blog.where(user_id: @current_user.id)
  end
end

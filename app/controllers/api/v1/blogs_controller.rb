# frozen_string_literal: true

class Api::V1::BlogsController < ApiController
  before_action :validate_api_token
  def index
    render json: Blog.where(user_id: @current_user.id)
  end

  def show; end
end

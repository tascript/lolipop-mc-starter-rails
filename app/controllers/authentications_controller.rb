# frozen_string_literal: true

class AuthenticationsController < ApplicationController
  before_action :validate_auth

  def create
    @authenticaton = Authentication.new
    @authenticaton.user = @current_user
    @authenticaton.save ? flash[:success] = 'APIトークンを作成しました。' : flash[:danger] = 'APIトークンの作成に失敗しました。'
    redirect_to dashboard_config_path
  end

  def update
    @authentication = Authentication.find_by(user_id: @current_user.id)
    if @authentication.nil?
      flash[:danger] = '不正な操作です'
      redirect_to dashboard_config_path
    end
    @authentication.reload_count = 0
    @authentication.save ? flash[:success] = 'APIトークンを更新しました。' : flash[:danger] = 'APIトークンの更新に失敗しました。'
    redirect_to dashboard_config_path
  end

  def destroy
    @authentication = Authentication.find_by(user_id: @current_user.id)
    if @authentication.nil?
      flash[:danger] = '不正な操作です'
      redirect_to dashboard_config_path
    end
    @authentication.destroy ? flash[:success] = 'APIトークンを削除しました。' : flash[:danger] = 'APIトークンの削除に失敗しました。'
    redirect_to dashboard_config_path
  end
end

# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :confirm_auth, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    User.all.each do |user|
      next unless user.email == user_params[:email]

      redirect_to(controller: :users, action: :new) && return
    end
    if @user.save
      flash[:success] = 'ユーザーの登録が完了しました。'
      redirect_to(controller: :home, action: :index) && return
    else
      flash[:danger] = 'ユーザーの登録に失敗しました。'
      render 'new' && return
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = 'ユーザー設定を更新しました'
      redirect_to dashboard_path
    else
      flash[:danger] = 'ユーザー設定の更新に失敗しました。'
      redirect_to dashboard_user_edit_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_digest)
  end
end

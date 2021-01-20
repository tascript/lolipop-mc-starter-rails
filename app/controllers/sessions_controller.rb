# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :confirm_auth, only: %i[new create]
  def new; end

  def create
    user = User.all.find { |u| u.email == params[:session][:email] }
    if user&.authenticate(params[:session][:password])
      log_in user
      flash[:success] = 'ログインに成功しました。'
      redirect_to(controller: :dashboard, action: :index)
    else
      flash[:danger] = 'メールアドレスもしくはパスワードに誤りがあります。'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end

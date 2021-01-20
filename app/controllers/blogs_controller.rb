# frozen_string_literal: true

class BlogsController < ApplicationController
  layout 'dashboard'
  before_action :validate_auth
  def new
    @blog = Blog.new
  end

  def detail
    @blog = Blog.find(params[:id])
    return unless @blog.nil?

    flash[:danger] = 'ブログの表示に失敗しました'
    render 'index' && return
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user = @current_user
    if @blog.save
      flash[:success] = 'ブログの登録が完了しました。'
    else
      flash[:danger] = 'ブログの登録に失敗しました。'
    end
    redirect_to dashboard_path
  end

  def destroy
    if Blog.find(params[:id]).destroy
      flash[:success] = 'ブログを削除しました'
      redirect_to dashboard_path
    else
      flash[:danger] = 'ブログの削除に失敗しました。'
      redirect_to controller: :dashboard, action: :detail
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(blog_params)
      flash[:success] = 'ブログを更新しました'
      redirect_to dashboard_path
    else
      flash[:danger] = 'ブログの更新に失敗しました。'
      redirect_to dashboard_blogs_edit_patch_path
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :document)
  end
end

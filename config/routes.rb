# frozen_string_literal: true

Rails.application.routes.draw do
  root   'home#index'
  get    'login',                            to: 'sessions#new'
  post   'login',                            to: 'sessions#create'
  delete 'logout',                           to: 'sessions#destroy'
  get    'signup',                           to: 'users#new'
  post   'signup',                           to: 'users#create'
  get    'dashboard',                        to: 'dashboard#index'
  get    'dashboard/blogs',                  to: 'blogs#new'
  post   'dashboard/blogs',                  to: 'blogs#create'
  get    'dashboard/blogs/:id',              to: 'blogs#detail'
  delete 'dashboard/blogs/:id',              to: 'blogs#destroy'
  patch  'dashboard/blogs/:id',              to: 'blogs#update', as: 'dashboard_blogs_edit_patch'
  get    'dashboard/blogs/:id/edit',         to: 'blogs#edit'
  get    'dashboard/config',                 to: 'config#index'
  get    'dashboard/user/edit',              to: 'config#edit'
  post   'dashboard/authentications',        to: 'authentications#create'
  delete 'dashboard/authentications',        to: 'authentications#destroy'
  patch  'dashboard/authentications/update', to: 'authentications#update'
  patch  'dashboard/edit',                   to: 'users#update', as: 'dashboard_config_edit_patch'

  namespace :api, format: 'json' do
    namespace :v1 do
      scope :blogs do
        root 'blogs#index'
      end
    end
  end
end

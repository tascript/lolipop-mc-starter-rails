# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :confirm_auth
  def index; end
end

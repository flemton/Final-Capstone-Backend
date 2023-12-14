class Api::UsersController < ApplicationController
  before_action :set_current_user, only: [:current]

  private

  def set_current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
end

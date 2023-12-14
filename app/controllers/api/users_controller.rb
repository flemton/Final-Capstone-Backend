class Api::UsersController < ApplicationController
  before_action :set_current_user, only: [:current]

  def current
    if @current_user
      render json: @current_user
    else
      render json: { error: 'Not logged in' }, status: :unauthorized
    end
  end
  
  private

  def set_current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end

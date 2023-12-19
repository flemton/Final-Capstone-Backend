class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:user][:username])

    if @user
      session[:user_id] = @user.id
      render json: { success: true, user_id: @user.id, message: 'Sign in was successful!' }
    else
      render json: { error: 'Invalid username' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end

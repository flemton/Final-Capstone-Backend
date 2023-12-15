class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:user][:email])

    if @user&.valid_password?(params[:user][:password])
       sign_in(@user)
      render json: { success: true, user_id: @user.id, message: 'Sign in was successful!' }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

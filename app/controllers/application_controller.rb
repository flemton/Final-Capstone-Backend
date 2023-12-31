class ApplicationController < ActionController::API
  before_action :set_current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  puts 'User in cont: ', @current_user

  private

  def set_current_user
    @current_user = current_user
  end
end

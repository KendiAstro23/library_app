class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def authenticate_user!
    unless current_user
      redirect_to new_session_path, alert: "You must be logged in to access this page."
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user
end
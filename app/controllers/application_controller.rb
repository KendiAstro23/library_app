# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_current_user  # ✅ Assign Current.user before every request

  def self.allow_unauthenticated_access(options = {})
    skip_before_action :authenticate_user!, options
  end

  private

  def authenticate_user!
    unless current_user
      redirect_to new_session_path, alert: "You must be logged in to access this page."
    end
    redirect_to new_session_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user
end
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # ✅ Fix: Ensure Current.user is assigned on every request
  def set_current_user
    Current.user = current_user  # ✅ Works because Current.user is now defined
  end

  def authenticated?
    current_user.present?
  end
  helper_method :authenticated?
end

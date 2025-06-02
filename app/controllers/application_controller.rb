# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Authentication

  before_action :authenticate_user!

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def self.allow_unauthenticated_access(options = {})
    skip_before_action :authenticate_user!, options
  end

  private

  def authenticate_user!
    unless current_user
      redirect_to new_session_path, alert: "You must be logged in to access this page."
    end
  end

  def current_user
    Current.user
  end
  helper_method :current_user

  # Ensure Current.user is assigned on every request
  def set_current_user
    Current.user = current_user
  end

  def authenticated?
    current_user.present?
  end
  helper_method :authenticated?
end

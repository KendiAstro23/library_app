module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :set_current_session
    helper_method :authenticated?, :current_user
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :authenticate_user!, **options
    end
  end

  private
    def authenticated?
      current_user.present?
    end

    def current_user
      Current.user
    end

    def set_current_session
      Current.session = find_session_by_cookie
      Current.user = Current.session&.user
    end

    def find_session_by_cookie
      Session.find_by(id: cookies.signed[:session_id]) if cookies.signed[:session_id]
    end

    def after_authentication_url
      session.delete(:return_to) || dashboard_path
    end

    def start_new_session_for(user)
      session = user.sessions.create!(
        user_agent: request.user_agent,
        ip_address: request.remote_ip,
        last_active_at: Time.current
      )
        Current.session = session
      Current.user = user
        cookies.signed.permanent[:session_id] = { value: session.id, httponly: true, same_site: :lax }
      end

    def destroy_session
      Current.session&.destroy
      Current.session = nil
      Current.user = nil
      cookies.delete(:session_id)
    end
end

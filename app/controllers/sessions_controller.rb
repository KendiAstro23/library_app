class SessionsController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def new
    redirect_to dashboard_path if authenticated?
  end

  def create
    user = User.find_by(email_address: params[:email_address]&.downcase)
    
    if user&.authenticate(params[:password])
      start_new_session_for(user)
      redirect_to after_authentication_url, notice: "Welcome back, #{user.name}!"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    destroy_session
    redirect_to root_path, notice: "You have been signed out."
  end
end

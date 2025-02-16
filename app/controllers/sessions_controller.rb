class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
  end

  def create
    # Match the parameter names with your form fields
    user = User.find_by(email_address: params[:email_address])
    
    if user&.authenticate(params[:password])
      # Standard session handling
      session[:user_id] = user.id
      # Redirect to your main authenticated path
      redirect_to dashboard_path, notice: "Logged in successfully!"
    else
      flash.now[:alert] = "Invalid email address or password"
      render :new
    end
  end

  def destroy
    # Standard session termination
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to books_path, notice: "Logged in successfully!" # Redirect to dashboard
    else
      flash[:alert] = "Invalid email or password"
      redirect_to root_path # Return to unified landing page
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end

def create
  @user = User.new(user_params)
  if @user.save
    session[:user_id] = @user.id
    redirect_to books_path, notice: "Account created successfully!" # Redirect to dashboard
  else
    flash[:alert] = @user.errors.full_messages.join(", ")
    redirect_to root_path # Return to unified landing page
  end
end
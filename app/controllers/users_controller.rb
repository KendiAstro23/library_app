class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
<<<<<<< HEAD
    if @user.save
      session[:user_id] = @user.id
      redirect_to books_path, notice: "Account created successfully!" # Redirect to dashboard
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity # Stay on the signup page with error messages

      # Automatically sign in the user after registration
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created successfully!"
    else
      render :new
>>>>>>> ce00263 (second draft, new files)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

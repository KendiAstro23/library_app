class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to books_path, notice: "Account created successfully!"
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to user_profile_path, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end
end

class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      start_new_session_for(@user)
      redirect_to dashboard_path, notice: "Welcome to the Library App!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
    @borrowed_books = @user.books.where(status: 'borrowed')
    @returned_books = @user.books.where(status: 'returned')
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    
    if @user.update(user_params)
      redirect_to user_profile_path, notice: "Profile updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email_address, :password, :password_confirmation)
  end
end

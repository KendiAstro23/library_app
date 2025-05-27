class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @borrowed_books = current_user.books.joins(:borrowings).where(borrowings: { returned_at: nil })
  end

<<<<<<< HEAD
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
=======
  def show
    @user = current_user  # Make sure to assign the logged-in user
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_profile_path(@user), notice: 'Profile updated successfully!'
    else
      render :edit
>>>>>>> c3c3bf0 (Improved README)
    end
  end
  
  private
  
  def user_params
<<<<<<< HEAD
<<<<<<< HEAD
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
=======
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end  
end
>>>>>>> bc5036a (Dashboard, borrowing page)
=======
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
>>>>>>> c3c3bf0 (Improved README)

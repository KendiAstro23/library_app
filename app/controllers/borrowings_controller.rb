class BorrowingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    if @book.available?
      @borrowing = current_user.borrowings.create(book: @book)
      redirect_to user_profile_path, notice: "Book borrowed successfully!"
    else
      redirect_to book_path(@book), alert: "Book is not available."
    end
  end

  def destroy
    @borrowing = Borrowing.find(params[:id])
    if @borrowing.user == current_user
      @borrowing.update(returned_at: Time.current)
      redirect_to user_profile_path, notice: "Book returned successfully!"
    else
      redirect_to user_profile_path, alert: "You cannot return this book."
    end
  end
end
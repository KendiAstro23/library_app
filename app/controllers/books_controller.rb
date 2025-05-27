class BooksController < ApplicationController
<<<<<<< HEAD
<<<<<<< HEAD
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :borrow, :return]

  def index
    @books = Book.all.includes(:borrowings)
  end

  def read_books
    @books = current_user.borrowed_books
    @borrowings = current_user.borrowings.where(returned_at: nil).includes(:book)
  end

  def show
  end

  def borrow
  if @book.borrowed?
    redirect_to books_path, alert: "Book is already borrowed."
  else
    borrowing = current_user.borrowings.create!(book: @book, borrowed_at: Time.current)
    redirect_to read_books_books_path, notice: "You have successfully borrowed '#{@book.title}'."
  end
end

  def return
    borrowing = current_user.borrowings.find_by(book: @book, returned_at: nil)

    if borrowing
      borrowing.update(returned_at: Time.current)
      redirect_to user_profile_path, notice: "You have successfully returned '#{@book.title}'!"
    else
      redirect_to user_profile_path, alert: "You haven't borrowed this book or it's already returned."
    end
  end

  private

  def set_book
    @book = Book.find_by(id: params[:id])
    unless @book
      redirect_to books_path, alert: "Book not found."
    end
  end
end

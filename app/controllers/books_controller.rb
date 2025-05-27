class BooksController < ApplicationController
<<<<<<< HEAD
<<<<<<< HEAD
  before_action :authenticate_user!

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end
end
=======
  def index
    @books = Book.all  # Fetch all books
  end
=======
  before_action :authenticate_user!
>>>>>>> c3c3bf0 (Improved README)

  def index
    @books = Book.all
    puts "Books count: #{@books.count}"
  end

  def read_books
    @books = Book.where(borrower_id: current_user.id)  # Or your relevant condition
  end
  

  def show
    @book = Book.find(params[:id])
  end

  def borrow
    @book = Book.find(params[:id])
    if @book.available?
      @book.borrowings.create(user: current_user, borrowed_at: Time.current)
      redirect_to user_profile_path, notice: "You have successfully borrowed '#{@book.title}'!"
    else
      redirect_to @book, alert: "This book is already borrowed."
    end
  end
<<<<<<< HEAD
end
>>>>>>> bc5036a (Dashboard, borrowing page)
=======

  def return
    @borrowing = current_user.borrowings.find_by(book_id: params[:id], returned_at: nil)
    if @borrowing
      @borrowing.update(returned_at: Time.current)
      redirect_to user_profile_path, notice: "You have successfully returned '#{@borrowing.book.title}'!"
    else
      redirect_to user_profile_path, alert: "You haven't borrowed this book."
    end
  end
end
>>>>>>> c3c3bf0 (Improved README)

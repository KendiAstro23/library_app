class BooksController < ApplicationController
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

  def show
    @book = Book.find(params[:id])  # Find book by ID
  end
  def borrow
    @book = Book.find(params[:id])
    @book.create_borrowing(user_id: current_user.id, borrowed_at: Time.now)
    flash[:notice] = "You have successfully borrowed '#{@book.title}'!"
    redirect_to read_books_path
  end
  
  

  def read_books
    @borrowed_books = Book.joins(:borrowings).where(borrowings: { returned_at: nil })
  end   
   

  private

  def set_book
    @book = Book.find_by(id: params[:id])
    unless @book
      flash[:alert] = "Book not found!"
      redirect_to read_books_path
    end
  end
end
>>>>>>> bc5036a (Dashboard, borrowing page)

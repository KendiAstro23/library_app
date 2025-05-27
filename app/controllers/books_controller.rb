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
end
>>>>>>> bc5036a (Dashboard, borrowing page)

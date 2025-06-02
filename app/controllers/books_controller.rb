class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :borrow, :return, :save, :unsave, :read]

  def index
    @books = Book.all
    
    if params[:search].present?
      google_books = GoogleBooksService.search(params[:search])
      open_library_books = OpenLibraryService.search_books(params[:search])
      
      @google_books = google_books.reject { |book| Book.exists?(isbn: book[:isbn]) }
      @open_library_books = open_library_books.reject { |book| Book.exists?(isbn: book[:isbn]) }
    end
  end

  def available
    @books = Book.where(status: 'available')
    render :index
  end

  def show
    @can_borrow = @book.available? && !current_user.borrowings.where(book: @book, returned_at: nil).exists?
    @is_saved = current_user.saved_books.exists?(book: @book)
  end

  def create
    if params[:isbn]
      create_from_google_books
    elsif params[:open_library_isbn]
      create_from_open_library
    else
      redirect_to books_path, alert: 'Invalid book source provided.'
    end
  end

  def borrow
    if @book.available?
      if current_user.borrowings.where(book: @book, returned_at: nil).exists?
        redirect_to @book, alert: "You have already borrowed this book."
      else
        borrowing = current_user.borrowings.create!(
          book: @book,
          borrowed_at: Time.current,
          due_date: 2.weeks.from_now
        )
        @book.update!(status: 'borrowed', borrower_id: current_user.id)
        redirect_to my_books_path, notice: "Book borrowed successfully! Due date: #{borrowing.due_date.strftime('%B %d, %Y')}"
      end
    else
      redirect_to @book, alert: "Sorry, this book is not available for borrowing."
    end
  end

  def return
    if @book.borrowed_by?(current_user)
      borrowing = current_user.borrowings.find_by!(book: @book, returned_at: nil)
      borrowing.update!(returned_at: Time.current)
      @book.update!(status: 'available', borrower_id: nil)
      redirect_to my_books_path, notice: "Book returned successfully!"
    else
      redirect_to @book, alert: "You cannot return this book."
    end
  end

  def save
    if current_user.saved_books.exists?(book: @book)
      redirect_to @book, alert: "You have already saved this book."
    else
      current_user.saved_books.create!(book: @book)
      redirect_to @book, notice: "Book saved successfully!"
    end
  end

  def unsave
    saved_book = current_user.saved_books.find_by(book: @book)
    if saved_book
      saved_book.destroy
      redirect_to @book, notice: "Book removed from saved list."
    else
      redirect_to @book, alert: "Book was not in your saved list."
    end
  end

  def read
    unless @book.borrowed_by?(current_user)
      redirect_to @book, alert: "You must borrow this book first to read it."
      return
    end

    if @book.has_online_copy && @book.read_url.present?
      @read_url = @book.read_url
    else
      # Fallback to Google Books preview if no Open Library copy is available
      @preview_url = GoogleBooksService.find_preview_url(@book.isbn)
      
      if @preview_url.nil?
        redirect_to @book, alert: "Sorry, no online version is available for this book."
      end
    end
  end

  private

  def create_from_google_books
    book_data = GoogleBooksService.find_by_isbn(params[:isbn])
    
    if book_data
      @book = Book.new(
        title: book_data[:title],
        author: book_data[:author],
        isbn: book_data[:isbn],
        image_url: book_data[:image_url],
        description: book_data[:description],
        published_date: book_data[:published_date],
        page_count: book_data[:page_count],
        categories: book_data[:categories],
        status: 'available'
      )

      if @book.save
        redirect_to @book, notice: 'Book was successfully added to the library.'
      else
        redirect_to books_path, alert: 'Could not add the book to the library.'
      end
    else
      redirect_to books_path, alert: 'Could not find book with that ISBN.'
    end
  end

  def create_from_open_library
    book_data = OpenLibraryService.get_book_by_isbn(params[:open_library_isbn])
    
    if book_data
      @book = Book.new(
        title: book_data[:title],
        author: book_data[:author],
        isbn: book_data[:isbn],
        image_url: book_data[:cover_url],
        description: book_data[:description],
        published_date: book_data[:published_date],
        page_count: book_data[:page_count],
        read_url: book_data[:read_url],
        has_online_copy: true,
        status: 'available'
      )

      if @book.save
        redirect_to @book, notice: 'Book was successfully added to the library.'
      else
        redirect_to books_path, alert: 'Could not add the book to the library.'
      end
    else
      redirect_to books_path, alert: 'Could not find book in Open Library.'
    end
  end

  def set_book
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to books_path, alert: "Book not found."
  end
end

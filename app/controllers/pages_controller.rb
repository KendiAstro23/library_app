class PagesController < ApplicationController
    allow_unauthenticated_access only: [:home]
    before_action :authenticate_user!, except: [:home]

    def home
        if authenticated?
            redirect_to dashboard_path
        else
            render layout: 'home'
        end
    end
  
    def dashboard
        @borrowed_books = current_user.borrowings.where(returned_at: nil).includes(:book).map(&:book)
        @returned_books = current_user.borrowings.where.not(returned_at: nil).includes(:book).map(&:book)
        @saved_books = current_user.saved_book_list
        @featured_books = Book.where(status: 'available')
                             .where.not(id: current_user.borrowings.pluck(:book_id))
                             .limit(6)
    end

    def my_books
        @borrowed_books = current_user.borrowings.where(returned_at: nil).includes(:book).map(&:book)
        @returned_books = current_user.borrowings.where.not(returned_at: nil).includes(:book).map(&:book)
        @saved_books = current_user.saved_book_list
    end
end
  
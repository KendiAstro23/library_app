class PagesController < ApplicationController
    before_action :authenticate_user! # Ensure user is logged in

    def home
        redirect_to dashboard_path if current_user.present?
    end
  
    def dashboard
        @borrowed_books = Book.where(borrower_id: current_user.id, status: 'borrowed')
        @returned_books = Book.where(borrower_id: current_user.id, status: 'returned')
        @relevant_books = Book.where(status: 'available').where.not(id: @borrowed_books.pluck(:id))
    end      
  end
  
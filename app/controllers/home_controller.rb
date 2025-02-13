class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    redirect_to books_path if current_user # Skip landing page if logged in
  end
end
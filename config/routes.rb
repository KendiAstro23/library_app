<<<<<<< HEAD
# config/routes.rb
Rails.application.routes.draw do
  get "home/index"
  root "home#index" # Unified landing page

  # Authentication routes
  get "sign_up", to: "users#new", as: :new_user
  post "sign_up", to: "users#create"
  get "login", to: "sessions#new", as: :new_session
  post "login", to: "sessions#create", as: :login
  delete "logout", to: "sessions#destroy", as: :destroy_session

  # Main dashboard
  resources :books, only: [:index, :show]
  resources :borrowings, only: [:create, :destroy]
  get "profile", to: "users#profile", as: :user_profile
end
=======
Rails.application.routes.draw do
  # Authentication routes
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # User registration routes
  get "sign_up", to: "users#new", as: :new_user
  post "sign_up", to: "users#create", as: :users  

  # Books routes (Including Borrow feature)
  resources :books, only: [:index, :show] do
    member do
      post 'borrow'  # Creates borrow_book_path(@book)
      post 'return'
    end
  end

  get "read_books", to: "books#read_books", as: :read_books  # Route for borrowed books

  # User profile routes
  resources :users, only: [:new, :create, :show, :edit, :update]
  get '/profile', to: 'users#show', as: 'user_profile' 
  get "/user_profile", to: "users#profile" 

  # Root and dashboard routes
  root "pages#home"
  get "dashboard", to: "pages#dashboard"
end
>>>>>>> ce00263 (second draft, new files)

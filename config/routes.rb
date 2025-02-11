Rails.application.routes.draw do
  root "books#index" # Main dashboard

  # Authentication routes
  get "sign_up", to: "users#new", as: :new_user
  post "sign_up", to: "users#create"
  get "login", to: "sessions#new", as: :new_session
  post "login", to: "sessions#create", as: :login
  delete "logout", to: "sessions#destroy", as: :destroy_session

  # Resource routes
  resources :books, only: [:index, :show]
  resources :borrowings, only: [:create, :destroy]
  get "profile", to: "users#profile", as: :user_profile
end
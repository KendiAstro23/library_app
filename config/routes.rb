Rails.application.routes.draw do
  # Existing authentication routes (for sign in)
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Add routes for user registration (sign up)
  get "sign_up", to: "users#new", as: :new_user
  post "sign_up", to: "users#create", as: :users

  # Defines the root path route ("/")
  root "pages#home"
  get "dashboard", to: "pages#dashboard"
end

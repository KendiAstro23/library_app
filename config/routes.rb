Rails.application.routes.draw do
  root "books#index"
  resources :books, only: [:index, :show]
  resources :borrowings, only: [:create, :destroy]
  get "profile", to: "users#profile", as: :user_profile
end
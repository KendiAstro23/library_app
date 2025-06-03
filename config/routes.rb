Rails.application.routes.draw do
  # Health check endpoint
  get "health", to: "health#show"

  # Root route
  root "pages#home"

  # Session routes
  resources :sessions, only: [:new, :create]
  delete "session", to: "sessions#destroy", as: :destroy_session

  # User routes
  resources :users, only: [:new, :create, :edit, :update]
  get "profile", to: "users#show", as: :user_profile
  get "profile/edit", to: "users#edit", as: :edit_profile

  # Book routes
  resources :books, only: [:index, :show, :create] do
    member do
      post :borrow
      post :return
      post :save
      delete :unsave
      get :read
      get :download # New route for downloading e-books
    end
    collection do
      get 'search'
      get 'available'
    end
  end

  # Dashboard routes
  get "dashboard", to: "pages#dashboard"
  get "my-books", to: "pages#my_books"

  # Borrowing routes
  resources :borrowings, only: [:create, :destroy]
  
  # Saved books routes
  resources :saved_books, only: [:create, :destroy]
end

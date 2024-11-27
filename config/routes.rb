Rails.application.routes.draw do
  root "home#index"

  get "login", to: "sessions#new", as: "new_session"
  post "login", to: "sessions#create", as: "user_sessions"
  delete "logout", to: "sessions#destroy", as: "logout"

  get "register/user", to: "users#new", as: "new_user_registration"
  post "user_registrations", to: "users#create", as: "user_registrations"
  post "events/:id/add_guest", to: "events#add_guest", as: "add_guest_to_event" # Adds a guest to a specific event

  resources :events do
    member do
      post :add_guest # Route to add a guest to a specific event
    end
    
    resources :guests, only: [ :create, :update, :destroy ] # Nested resource for guests
  end

  resources :guests, only: [ :index ] do
    patch :update_attendance, on: :collection
  end
end

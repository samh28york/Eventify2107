Rails.application.routes.draw do
  root "home#index"

  get "login", to: "sessions#new", as: "new_session"
  post "login", to: "sessions#create", as: "user_sessions"
  delete "logout", to: "sessions#destroy", as: "logout"

  get "register/user", to: "users#new", as: "new_user_registration"
  post "user_registrations", to: "users#create", as: "user_registrations"

  resources :events do
    member do
      post "add_guest"  # Adds a guest to a specific event
    end
    resources :guest_lists
  end

  resources :guests, only: [ :index ] do
    patch :update_attendance, on: :collection
  end

  resources :events do
    resources :guest_lists, only: [ :index ]
  end
end

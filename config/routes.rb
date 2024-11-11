Rails.application.routes.draw do
  get "guest_lists/index"
  get "home/index"
  root "home#index"

  get "login/guest", to: "sessions#new_guest", as: "new_guest_session"
  get "login/organizer", to: "sessions#new_organizer", as: "new_organizer_session"

  post "guest_sessions", to: "sessions#create_guest"
  post "organizer_sessions", to: "sessions#create_organizer"

  get "register/guest", to: "registrations#new_guest", as: "new_guest_registration"
  get "register/organizer", to: "registrations#new_organizer", as: "new_organizer_registration"

  post "guest_registrations", to: "registrations#create_guest"
  post "organizer_registrations", to: "registrations#create_organizer"

  get "guest_home", to: "home#guest_home", as: "guest_home"
  get "organizer_home", to: "home#organizer_home", as: "organizer_home"

  resources :events do
    member do
      post "add_guest"  # Adds a guest to a specific event
    end
    resources :guest_lists
    resources :budgets
    resources :itineraries
    resources :gift_registries
    resources :notifications
  end

  resources :guests, only: [ :index ] do
    patch :update_attendance, on: :collection
  end

  resources :events do
    resources :guest_lists, only: [ :index ]
  end
end

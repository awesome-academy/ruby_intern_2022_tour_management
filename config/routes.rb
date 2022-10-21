Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    post "/booking", to: "bookings#create"
    get "/booking", to: "bookings#show"
    resources :tours, only: %i(index show)
    resources :tour_schedules, only: :show
    namespace :admin do
      root "static_pages#index"
      resources :tours
      resources :bookings, only: %i(index update)
    end
  end
end

require "sidekiq/web"

Rails.application.routes.draw do

  mount Sidekiq::Web => "/sidekiq"
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"
    devise_for :users, controllers: {passwords: "passwords"}
    resources :reviews, only: :create
    resource :bookings, only: %i(create show)
    resources :bookings, only: :destroy
    resources :tours, only: %i(index show)
    resources :tour_schedules, only: :show
    namespace :admin do
      root "static_pages#index"
      resources :tours do
        collection {post :import}
      end
      resources :bookings, only: %i(index update)
    end
    namespace :api do
      namespace :v1 do
        root "tours#index"
        post "/authentication", to: "authentication#authenticate_user"
        get "/bookings", to: "bookings#index"
      end
    end
  end
end

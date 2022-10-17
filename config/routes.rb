Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :tours, only: %i(index show)
    namespace :admin do
      root "static_pages#index"
      resources :tours
    end
  end
end

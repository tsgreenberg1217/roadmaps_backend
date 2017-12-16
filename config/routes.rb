Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :trips
      post "/auth", to: "sessions#create"
      get "/current_user", to: "sessions#show"
    end
  end
end

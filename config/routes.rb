Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :trips
      resources :stops
      resources :friendships
      post "/auth", to: "sessions#create"
      get "/current_user", to: "sessions#show"
      get "/ontrips", to: "trips#ontrips"
      get "/ontrips/:id", to: "trips#show_ontrips"
    end
  end
end

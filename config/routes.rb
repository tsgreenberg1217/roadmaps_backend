Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :friendships
      resources :users
      resources :trips do
        resources :stops do
          resources :activities do
            resources :pictures
          end
        end
      end
      post "/auth", to: "sessions#create"
      get "/current_user", to: "sessions#show"
      get "/ontrips", to: "trips#ontrips"
      get "/ontrips/:id", to: "trips#show_ontrips"
      patch "/update-order", to: "stops#updateOrder"
      get "/everytrip", to: "trips#everytrip"
      post "/validations/start-end", to: "validations#start_end"
    end
  end
end

Rails.application.routes.draw do
  root 'homes#index'
  get '/homes', to: 'homes#index'
  post '/homes', to: 'homes#create'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :neighborhoods, only: [:index]
      resources :addresses, only: [:index]
      resources :neighborhood_rent, only: [:index]
    end
  end
end

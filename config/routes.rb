Rails.application.routes.draw do
  root 'homes#index'
  # resources :homes, only: [:index]
  get '/homes', to: 'homes#index'
  post '/homes', to: 'homes#create'
end

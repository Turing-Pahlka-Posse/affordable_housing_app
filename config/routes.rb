Rails.application.routes.draw do
  root 'home#index'

  post '/home', to: 'home#create', as: :home
  # resources :homes, only: [:create, :index]
end

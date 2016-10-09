require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  devise_for :users, controllers: {
    registrations: 'user/registrations',
    omniauth_callbacks: 'user/omniauth_callbacks'
  }

  resources :events, only: :index
  get 'pages/about'
  get 'pages/map'
  get '/events/category/:category', to: 'events#category'
  get '/events/location/:location', to: 'events#location'
  mount Sidekiq::Web => '/sidekiq'
end

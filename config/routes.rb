require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  devise_for :users, controllers: {
    registrations: 'user/registrations',
    omniauth_callbacks: 'user/omniauth_callbacks'
  }

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :events, only: [:index, :show]
      resources :locations, only: [:show]
    end
  end
  get "/api/v1/events/category/:category",
    to: "api/v1/events#category", defaults: { format: :json }
  get "/api/v1/events/location/:location",
    to: "api/v1/events#location", defaults: { format: :json }
  get "/api/v1/events/postalcode/:postalcode",
    to: "api/v1/events#postalcode", defaults: { format: :json }

  resources :events , only: [:index, :show]
  get 'pages/about'
  get 'pages/map'
  get 'pages/map_with_location/:location', to: 'pages#map_with_location'
  get 'pages/map_with_category/:category', to: 'pages#map_with_category'
  get '/events/category/:category', to: 'events#category'
  get '/events/location/:location', to: 'events#location'
  get '/events/postalcode/:postalcode', to: 'events#postalcode', as: :events_postalcode
  get '/events/district/:district', to: 'events#district'
  mount Sidekiq::Web => '/sidekiq'

  get '*unmatched_route', to: 'application#route_not_found'
end

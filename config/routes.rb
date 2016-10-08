require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  devise_for :users, controllers: {
    registrations: 'user/registrations',
    omniauth_callbacks: 'user/omniauth_callbacks'
  }

  mount Sidekiq::Web => '/sidekiq'
end

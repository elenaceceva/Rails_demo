Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :posts
  devise_for :users, only: %w[sessions#new session#destroy]
  use_doorkeeper
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts
        end
      end
    end
  resources :posts, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

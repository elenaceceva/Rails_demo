Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  use_doorkeeper
  devise_for :users, only: %w[sessions#new session#destroy]

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts
        end
      end
  end
  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

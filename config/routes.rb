Rails.application.routes.draw do
  apipie
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  use_doorkeeper
  devise_for :users,:only => [:sessions, :confirmations]
  get '/confirmation_getting_started' => 'api/v1/users#show'
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
      get 'search/:action' => 'searches#:action'
    end
  end
  root 'admin/dashboard#index'
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

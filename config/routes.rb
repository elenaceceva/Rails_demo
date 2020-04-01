Rails.application.routes.draw do
  apipie
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  use_doorkeeper

  devise_for :users,:only => [:sessions, :confirmations, :passwords]

  root 'admin/dashboard#index'
  get '/users/sign_in', to: 'devise/sessions#new', as: 'new_user_registration'

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts
        end
      end
  end

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :show ]
      get 'search/:action' => 'searches#:action'
    end
  end
end

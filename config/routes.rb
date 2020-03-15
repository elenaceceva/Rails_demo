Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      devise_for :users, only: :sessions
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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

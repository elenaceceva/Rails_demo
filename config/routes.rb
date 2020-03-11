Rails.application.routes.draw do
  resources :posts
  devise_for :users
  use_doorkeeper
  namespace :api do
    namespace :v1 do
        resources :posts
      end
    end

  resources :posts, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

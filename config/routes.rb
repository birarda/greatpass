Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'items#search'

  get 'search', to: 'items#search'
  get 'items/search'

  get 'users/:platform_string/:platform_username', to: 'items#search', as: 'platform_user'

  # get 'users/:platform/:platform_username', to: 'users#show', as: 'platform_user'

  resources :users, only: [:update]

  namespace :user do
    resources :items, only: [:index, :create, :destroy]
    get 'wishlist', to: 'items#wishlist'
  end
end

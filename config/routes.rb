Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'items#search'

  get 'search', to: 'items#search'
  get 'items/search'

  get 'users/reddit/:reddit_username', to: 'users#inventory', as: 'reddit_user'
  get 'users/reddit/:reddit_username/wishlist', to: 'users#wishlist', as: 'reddit_user_wishlist'

  get 'users/:platform_string/:platform_username', to: 'items#search', as: 'platform_user', platform_username: /[^\/]+/
  get 'users/:platform_string/:platform_username/wishlist', to: 'users#wishlist', as: 'platform_user_wishlist', platform_username: /[^\/]+/

  # get 'users/:platform/:platform_username', to: 'users#show', as: 'platform_user'

  resources :users, only: [:update]

  resources :items, only: [:index]
  get 'items/:item_slug', to: 'items#search', as: 'item'

  namespace :user do
    resources :items, only: [:index, :create, :destroy]
    delete 'items', to: 'items#inventory_clear', as: 'inventory_clear'
    get 'wishlist', to: 'items#wishlist', as: 'wishlist_index'
    post 'wishlist', to: 'items#create', as: 'wishlist_add'
    delete 'wishlist/:id', to: 'items#destroy', as: 'wishlist'
    delete 'wishlist', to: 'items#wishlist_clear', as: 'wishlist_clear'

    # mailboxer
    resources 'messages', only: [:create], constraints: { format: 'json' }
    resources 'conversations', only: [:index, :show, :destroy]
    resources 'conversations', only: [:create], constraints: { format: 'json' }

    get 'inbox', to: 'conversations#index'
  end
end

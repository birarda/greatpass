Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'items#search'

  get 'search', to: 'items#search'
  get 'items/search'

  get 'users/:platform_string/:platform_username', to: 'items#search', as: 'platform_user', platform_username: /.*/
  get 'users/:platform_string/:platform_username/wishlist', to: 'users#wishlist', as: 'platform_user_wishlist', platform_username: /.*/

  # get 'users/:platform/:platform_username', to: 'users#show', as: 'platform_user'

  resources :users, only: [:update]

  resources :items, only: [:index]
  get 'items/:item_slug', to: 'items#search', as: 'item'

  namespace :user do
    resources :items, only: [:index, :create, :destroy]
    get 'wishlist', to: 'items#wishlist', as: 'wishlist_index'
    post 'wishlist', to: 'items#create', as: 'wishlist_add'
    delete 'wishlist/:id', to: 'items#destroy', as: 'wishlist'
  end
end

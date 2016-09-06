Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'items#index'

  resources :items, only: [:index]
  namespace :user do
    resources :items, only: [:index, :create, :destroy]
  end
end

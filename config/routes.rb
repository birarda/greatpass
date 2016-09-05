Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :user do
    get 'inventory', to: 'items#inventory'
    resources :items, only: [:new, :create]
  end
end

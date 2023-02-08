Rails.application.routes.draw do  
  devise_for :users
  get 'dashboard/index'
  root to: 'dashboard#index'

  resources :books
  resources :categories
  resources :transactions
  resources :users, except: [:new, :create]
end

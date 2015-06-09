Rails.application.routes.draw do
  get 'pages/algorithm'
  get 'pages/fibonacci'
  get 'pages/sort_array'

  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :tickets
end

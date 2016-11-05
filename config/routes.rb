Rails.application.routes.draw do
  root 'photos#index'
  get 'pages/home'

  resources :photos
  devise_for :users
  resources :users
end

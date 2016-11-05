Rails.application.routes.draw do
  root 'pages#home'

  resources :photos
  devise_for :users
  resources :users
end

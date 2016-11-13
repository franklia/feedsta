Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords', sessions: 'users/sessions', instagram: 'instagram' }
 

  get 'instagram/auth', to: 'instagram#auth'
  # post 'instagram', to: 'instagram#show'
  # match 'instagram/auth' => 'instagram#auth', via: [:get, :post]

  # resources :instagram

  resources :photos
end

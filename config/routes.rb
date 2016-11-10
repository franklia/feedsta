Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords', sessions: 'users/sessions' }

  resources :photos
end

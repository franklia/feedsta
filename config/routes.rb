Rails.application.routes.draw do

  root 'pages#home'

  devise_for :users, controllers: {application: 'application', instagram: 'instagram', photos: 'photos' }
 
  get 'instagram/auth', to: 'instagram#auth'

  resources :photos do
  	collection do
  		get 'saved'
  		post 'save_order'
  	end
  end

  get 'users_followed/index'
  # post 'users_followed/suggest'
  get 'users_followed/followers'
  get 'users_followed/following'
  get 'users_followed/unfollow'
  post 'users_followed/insta_unfollow'

end

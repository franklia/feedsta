Rails.application.routes.draw do
  get 'users_followed/index'

  get 'users_followed/unfollow'

  get 'users_followed/suggest'

  root 'pages#home'

  devise_for :users, controllers: {application: 'application', instagram: 'instagram', photos: 'photos' }
 
  get 'instagram/auth', to: 'instagram#auth'

  resources :photos do
  	collection do
  		get 'saved'
  		post 'save_order'
  	end
  end

end

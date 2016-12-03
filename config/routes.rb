Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users, controllers: {application: 'application', instagram: 'instagram', photos: 'photos' }
 
  get 'instagram/auth', to: 'instagram#auth'

  resources :photos do
  	collection do
  		get 'saved'
  	end
  end

end

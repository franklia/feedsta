class ApplicationController < ActionController::Base
  	protect_from_forgery with: :exception

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
	devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
	end

	# To redirect to photos/index after logging in
	def after_sign_in_path_for(resource)
		if InstaAccount.exists?(user_id: current_user.id)
			"https://api.instagram.com/oauth/authorize/?client_id=#{ENV['INSTA_CLIENT_ID']}&redirect_uri=#{redirect_url}&response_type=code"
		else
			redirect_to 'photos/index'
		end

		token = InstaAccount.find_by user_id: current_user.id
      	
    end

   def redirect_url
  	'http://localhost:3000/instagram/auth'
  end

end

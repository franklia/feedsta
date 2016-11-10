class ApplicationController < ActionController::Base
  	protect_from_forgery with: :exception

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
	devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
	end

	# To redirect to photos/index after logging in
	# def after_sign_in_path_for(resource)
 #      # photos_path(resource)
 #      redirect_to "https://api.instagram.com/oauth/authorize/?client_id=ENV['INSTA_CLIENT_ID']&redirect_uri=REDIRECT-URI&response_type=code"
 #    end

end

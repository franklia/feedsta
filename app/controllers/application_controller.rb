class ApplicationController < ActionController::Base
  	protect_from_forgery with: :exception

  	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?

	def current_user
	  @current_user ||= (warden.authenticate(scope: :user) || User.new)
	end


	# @account = InstaAccount.find(current_user.id)

	protected

	def configure_permitted_parameters
	devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
	end

	# To redirect to photos/index after logging in
	def after_sign_in_path_for(resource)
		if InstaAccount.exists?(user_id: current_user.id)
			photos_path
		else
			instagram_auth_path
		end
    end

end

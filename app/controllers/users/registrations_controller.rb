class Users::RegistrationsController < Devise::RegistrationsController
  protected
    def after_sign_up_path_for(resource)
      # photos_path(resource)
      redirect_to "https://api.instagram.com/oauth/authorize/?client_id=ENV['INSTA_CLIENT_ID']
&redirect_uri=REDIRECT-URI&response_type=code"
    end

    def after_update_path_for(resource)
      photos_path(resource)
    end
end
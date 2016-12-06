# class Users::PasswordsController < Devise::PasswordsController
class PasswordsController < Devise::PasswordsController
  protected
    def after_resetting_password_path_for(resource)
      photos_path(resource)
    end
end
class Users::SessionsController < Devise::SessionsController
  def create
    super do |resource|
      if InstaAccounts.find_by user_id: current_user
      	"https://api.instagram.com/oauth/authorize/?client_id=CLIENT-ID&redirect_uri=REDIRECT-URI&response_type=code"
      else

      end
    end
  end
end
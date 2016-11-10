class Users::SessionsController < Devise::SessionsController
  def create
    # super do |resource|
      # if InstaAccounts.find_by user_id: current_user
      	redirect_to "https://api.instagram.com/oauth/authorize/?client_id=#{ENV['INSTA_CLIENT_ID']}&redirect_uri=#{redirect_url}&response_type=code"
      # else

      # end
    # end
  end

  private

  def redirect_url
  	'http://localhost:3000/instagram/auth'
  end
end
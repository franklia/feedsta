class InstagramController < ApplicationController

	require 'net/http'
 	require 'json'

	def auth
		if params[:code]
			client_id = ENV['INSTA_CLIENT_ID']
			client_secret = ENV['INSTA_SECRET_KEY']
			grant_type = 'authorization_code'
			redirect_uri = 'http://localhost:3000/instagram/auth'
			code = params[:code]

		    params = {'client_id' => client_id, 'client_secret' => client_secret, 'grant_type' => grant_type, 'redirect_uri' => redirect_uri, 'code' => code}

		    post = Net::HTTP.post_form(URI.parse("https://api.instagram.com/oauth/access_token"), params)
		    @response = JSON.parse(post.body)

		    @account = InstaAccount.new
			@account.token = @response['access_token']
			@account.username = @response['user']['username']
			@account.name = @response['user']['full_name']
			@account.profile_pic = @response['user']['profile_picture']
			@account.instagram_id = @response['user']['id']
			if user_signed_in?
				@account.user_id = 3
			else 
				@account.user_id = 5
			end
			@account.save!
		end
	end

	def show
			
	end
end



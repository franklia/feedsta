class InstagramController < ApplicationController

	require 'net/http'
 	require 'json'

	def auth
		if !params[:code]
			redirect_to "https://api.instagram.com/oauth/authorize/?client_id=#{ENV['INSTA_CLIENT_ID']}&redirect_uri=#{ENV['REDIRECT_URL']}&response_type=code&scope=basic+public_content+follower_list+relationships"
		else
			client_id = ENV['INSTA_CLIENT_ID']
			client_secret = ENV['INSTA_SECRET_KEY']
			grant_type = 'authorization_code'
			redirect_uri = ENV["REDIRECT_URL"]
			code = params[:code]

		    params = {'client_id' => client_id, 'client_secret' => client_secret, 'grant_type' => grant_type, 'redirect_uri' => redirect_uri, 'code' => code}

		    post = Net::HTTP.post_form(URI.parse("https://api.instagram.com/oauth/access_token"), params)
		    @response = JSON.parse(post.body)

		    @account = InstaAccount.new
			@account.token = @response['access_token']
			@account.username = @response['user']['username']
			@account.name = @response['user']['full_name'] unless @response['user']['full_name'].blank?
			@account.profile_pic = @response['user']['profile_picture'] unless @response['user']['profile_picture'].blank?
			@account.instagram_id = @response['user']['id']
			@account.user_id = current_user.id
			@account.save!
			redirect_to photos_path
		end
	end

	def show
			
	end

end



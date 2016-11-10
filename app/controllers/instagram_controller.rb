class InstagramController < ApplicationController

	def auth
		client_id = ENV['INSTA_CLIENT_ID']
		client_secret = ENV['INSTA_SECRET_KEY']
		grant_type = 'authorization_code'

		code = params[:code]
	end
end

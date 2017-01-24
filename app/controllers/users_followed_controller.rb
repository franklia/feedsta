class UsersFollowedController < ApplicationController
  def index
  	# Get insta followers
    insta_account = InstaAccount.find_by(user_id: current_user.id)
    uri = URI('https://api.instagram.com/v1/users/self/followed-by/')
    params = {'access_token' => insta_account.token}
    uri.query = URI.encode_www_form(params)

    Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request 
      @followers_response = JSON.parse(response.body)
    end

    @insta_followers = []
    @followers_response['data'].each do |array|
    @insta_followers << array['id']
    end

    @followers = @insta_followers.length

    # Get insta following
    uri = URI('https://api.instagram.com/v1/users/self/follows/')
    params = {'access_token' => insta_account.token}
    uri.query = URI.encode_www_form(params)

    Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request 
      @following_response = JSON.parse(response.body)
    end

    @insta_following = []
    @following_response['data'].each do |array|
    @insta_following << array['id']
    end

    @following = @insta_following.length

    # Get "Not following me back" 
    @not_following = @insta_following - @insta_followers
    @not_following = @not_following.length

  end

  

  def unfollow
  end

  def suggest
    if params[:data]
      tag = params[:data]

      # Search insta hashtag
      insta_account = InstaAccount.find_by(user_id: current_user.id)
      uri = URI("https://api.instagram.com/v1/tags/#{tag}/media/recent/")
      params = {'access_token' => insta_account.token}
      uri.query = URI.encode_www_form(params)

      Net::HTTP.start(uri.host, uri.port,
        :use_ssl => uri.scheme == 'https') do |http|
        request = Net::HTTP::Get.new uri
        response = http.request request 
        @tag_response = JSON.parse(response.body)
      end

      @suggested_followers = []
      @tag_response['data'].each do |data|
        @suggested_followers << {id: data["user"]["id"], username: data["user"]["username"]}
      end

      @unique_followers = @suggested_followers.uniq { |hash| hash[:id] }

    end
  end
end

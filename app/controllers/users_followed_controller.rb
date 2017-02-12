class UsersFollowedController < ApplicationController

  before_action :get_token  #, :except => [:create, :update, :destroy]

  def index
  	
    # Get users following me
    @followers_response = get_followers()
    @followers_num = @followers_response['data'].length

    
    # Get users i'm following
    @following_response = get_following()
    @following_num = @following_response['data'].length

    # Get "Not following me back" 
    @not_following = @following_response['data'] - @followers_response['data']
    @not_following_num = @not_following.length

  end

  def followers
    @followers = get_followers()
  end

  def following
    @following = get_following()
  end

  def unfollow
    @followers = get_followers()
    @following = get_following()
    @following_not = @following['data'] - @followers['data']
  end

  def insta_unfollow
    if params[:user_id]
      @user_id = params[:user_id].to_i
      @access_token = @token["access_token"]
      @parameters = {'access_token' => @insta_account.token, 'action' => 'unfollow'}

      url = "https://api.instagram.com/v1/users/#{@user_id}/relationship";
      uri = URI(url)
      form_data = URI.encode_www_form(@parameters)

      Net::HTTP.start(uri.host, uri.port,
        :use_ssl => uri.scheme == 'https') do |http|
        request = Net::HTTP::Post.new uri
        request.body = form_data
        response = http.request request 
        @unfollow_response = JSON.parse(response.body)
      end

      render json: @unfollow_response

    end
  end

  def insta_follow
    if params[:user_id]
      @user_id = params[:user_id].to_i
      @access_token = @token["access_token"]
      @parameters = {'access_token' => @insta_account.token, 'action' => 'follow'}

      url = "https://api.instagram.com/v1/users/#{@user_id}/relationship";
      uri = URI(url)
      form_data = URI.encode_www_form(@parameters)

      Net::HTTP.start(uri.host, uri.port,
        :use_ssl => uri.scheme == 'https') do |http|
        request = Net::HTTP::Post.new uri
        request.body = form_data
        response = http.request request 
        @follow_response = JSON.parse(response.body)
      end

      render json: @follow_response

    end
  end

  # def suggest
  #   if params[:data]
  #     tag = params[:data]

  #     # Search insta hashtag
  #     insta_account = InstaAccount.find_by(user_id: current_user.id)
  #     uri = URI("https://api.instagram.com/v1/tags/#{tag}/media/recent/")
  #     params = {'access_token' => insta_account.token}
  #     uri.query = URI.encode_www_form(params)

  #     Net::HTTP.start(uri.host, uri.port,
  #       :use_ssl => uri.scheme == 'https') do |http|
  #       request = Net::HTTP::Get.new uri
  #       response = http.request request 
  #       @tag_response = JSON.parse(response.body)
  #     end

  #     @suggested_followers = []
  #     @tag_response['data'].each do |data|
  #       @suggested_followers << {id: data["user"]["id"], username: data["user"]["username"]}
  #     end

  #     @unique_followers = @suggested_followers.uniq { |hash| hash[:id] }

  #   end
  # end

  private

    def get_token
      @insta_account = InstaAccount.find_by(user_id: current_user.id)
      @token = {'access_token' => @insta_account.token}
    end

    def http_request(uri)
      Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        request = Net::HTTP::Get.new uri
        response = http.request request 
        return json = JSON.parse(response.body)
      end
    end

    def get_followers()
      uri = URI('https://api.instagram.com/v1/users/self/followed-by/')
      uri.query = URI.encode_www_form(@token)
      return http_request(uri)
    end

    def get_following()
      uri = URI('https://api.instagram.com/v1/users/self/follows/')
      uri.query = URI.encode_www_form(@token)
      return http_request(uri)
    end

end

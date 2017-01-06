class PhotosController < ApplicationController
  require 'net/http'
  require 'json'

  before_action :authenticate_user!
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  # before_action :account_info

  # show all saved photos, without showing instagram photos
  def saved
    @saved_photos = Photo.where(user_id: current_user.id)    
  end

  # GET /photos (show the feed)
  def index
    @photos = Photo.select(:id, :url).where(user_id: current_user.id).where(status: 'pending')
    @user = User.find_by(id: current_user.id)

    # Get insta account info
    insta_account = InstaAccount.find_by(user_id: current_user.id)
    uri = URI('https://api.instagram.com/v1/users/self/')
    params = {'access_token' => insta_account.token}
    uri.query = URI.encode_www_form(params)

    Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request 
      @account = JSON.parse(response.body)
    end

    @account_info = {}
    @account_info.store(:username, @account["data"]["username"])
    @account_info.store(:full_name, @account["data"]["full_name"])
    @account_info.store(:bio, @account["data"]["bio"])
    @account_info.store(:profile_picture, @account["data"]["profile_picture"])
    @account_info.store(:posts, @account["data"]["counts"]["media"])
    @account_info.store(:followed_by, @account["data"]["counts"]["followed_by"])
    @account_info.store(:following, @account["data"]["counts"]["follows"])

    # Get insta photos
    insta_account = InstaAccount.find_by(user_id: current_user.id)
    uri = URI('https://api.instagram.com/v1/users/self/media/recent/')
    params = {'access_token' => insta_account.token, 'count' => 12}
    uri.query = URI.encode_www_form(params)

    Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request 
      @insta_response = JSON.parse(response.body)
    end

    @insta_photos = []
    @insta_response['data'].each do |array|
    @insta_photos << array['images']['low_resolution']['url']
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    redirect_to action: "saved"
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user

    respond_to do |format|
      if @photo.save
        format.html { redirect_to photos_path, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:caption, :status, :position, :photo_credit, :url, :user_id)
    end

    # def account_info
    #     @account = InstaAccount.find(current_user.id)
    # end
end

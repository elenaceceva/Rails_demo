class Api::V1::SearchesController < BaseController

  def_param_group :user do
    param :user, Hash, :desc => "User info" do
      param :email, String, :desc => "Email" , :required => true
      param :nickname, String, :desc => "Nickname", :required => true
      param :firstname, String, :desc => "Firstname"
      param :lastname, String, :desc => "Lastname"
    end
  end

  def_param_group :post do
    param :post, Hash, :desc => "Post info" do
      param :title, String, :desc => "Title" , :required => true
      param :description, String, :desc => "Description", :required => true
      param :user_id, Integer, required: true
    end
  end

  def_param_group :location_attributes do
    param :location_attributes, Hash, :desc => "Location attributes" do
      param :city, String, :desc => "City", :required => true
      param :country, String, :desc => "Country", :required => true
      param :latitude, Float, :desc => "Latitude", :required => true
      param :longitude, Float, :desc => "Longitude", :required => true
    end
  end

  api :GET, '/api/v1/search/users_by_nickname?nickname=:nickname', 'Show all users with given nickname'
  returns :array_of => :user, :desc => 'List of users'
  param_group :user
  def users_by_nickname
    @results = User.where('nickname ILIKE ?', params[:nickname])
    render json: @results
  end

  api :GET, '/api/v1/search/users_by_location?latitude=:latitude&longitude=:longitude', 'Show all users within 10km of location'
  returns :array_of => :user, :desc => 'List of users'
  param_group :user
  param_group :location_attributes
  def users_by_location
    @users = []
    @locations = Location.within(10, :origin => [params[:latitude], params[:longitude]])
    @locations.each do |location|
    @users << location.users
    end
    @users.flatten
    render json: @users
  end

  api :GET, '/api/v1/search/posts_by_title?title=:title', 'Lists all posts with given title'
  returns :array_of => :user, :desc => 'List of posts'
  param_group :post
  def posts_by_title
    @results = Post.where('title ILIKE ?', params[:title])
    render json: @results
  end

  api :GET, '/api/v1/search/posts_by_location?latitude=:latitude&longitude=:longitude', 'Show all posts within 10km of location'
  returns :array_of => :user, :desc => 'List of users'
  param_group :post
  param_group :location_attributes
  def posts_by_location
    @posts = []
    @locations = Location.within(10, :origin => [params[:latitude], params[:longitude]])
    @locations.each do |location|
      @posts << location.posts
    end
    @posts.flatten
    render json: @posts
  end
end


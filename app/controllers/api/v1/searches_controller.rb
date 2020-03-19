class Api::V1::SearchesController < BaseController

  def_param_group :user do
    param :user, Hash, :desc => "User info" do
      param :email, String, :desc => "Email" , :required => true
      param :nickname, String, :desc => "Nickname", :required => true
      param :firstname, String, :desc => "Firstname"
      param :lastname, String, :desc => "Lastname"
      param :location_id, Integer, required: true
    end
  end

  def_param_group :post do
    param :post, Hash, :desc => "Post info" do
      param :title, String, :desc => "Title" , :required => true
      param :description, String, :desc => "Description", :required => true
      param :user_id, Integer, required: true
      param :location_id, Integer, required: true
    end
  end

  api :GET, '/api/v1/search/users_by_nickname?nickname=:nickname', 'Show all users with given nickname'
  returns :array_of => :user, :desc => 'List of users'
  def users_by_nickname
    search do
      @matches = []
      User.all.each do |user|
        if (user.nickname.include? params[:nickname])
          matches << user
        end
      end
      @matches
    end
  end

  api :GET, '/api/v1/search/users_by_location?latitude=:latitude&longitude=:longitude', 'Show all users within 10km of location'
  returns :array_of => :user, :desc => 'List of users'
  def users_by_location
    search do
      @users = []
      @locations = Location.within(10, :origin => [params[:latitude], params[:longitude]])
      @locations.each do |location|
        @users << location.users
      end
      @users.flatten
    end
  end

  api :GET, '/api/v1/search/posts_by_title?title=:title', 'Lists all posts with given title'
  returns :array_of => :user, :desc => 'List of posts'
  def posts_by_title
    search do
      @matches = []
      Post.all.each do |post|
        if (post.title.include? params[:title])
          @matches << post
        end
      end
      @matches
    end
  end

  api :GET, '/api/v1/search/posts_by_location?latitude=:latitude&longitude=:longitude', 'Show all posts within 10km of location'
  returns :array_of => :user, :desc => 'List of users'
  def posts_by_location
    search do
      @posts = []
      @locations = Location.within(10, :origin => [params[:latitude], params[:longitude]])
      @locations.each do |location|
        @posts << location.posts
      end
      @posts.flatten
    end
  end

  private

  def search(&block)
    if params[:q]
      @results = yield if block_given?
      render json: @results
    else
      redirect_to root_url, :notice => 'No search query was specified.'
    end
  end

end

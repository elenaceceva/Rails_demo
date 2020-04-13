class Api::V1::PostsController < BaseController
  before_action :set_post, only: [:show, :update, :destroy]
  #before_action :doorkeeper_authorize! unless Rails.env.test?

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

  api :GET, "/api/v1/posts", "Show all posts "
  returns :array_of => :post, :code => 200, :desc => "All posts"
  def index
    if (params.has_key? 'user_id')
      @posts = Post.where(user_id: params[:user_id]).order('created_at DESC').page(params[:page]).per(params[:per])
    else
      @posts = Post.all.order("created_at DESC").page(params[:page])
    end
    render json: @posts, status: 200, data: @posts
  end

  api :GET, "/api/v1/users/:user_id/posts/:id", "Show post "
  returns :code => 200, :desc => "Detailed info about the posts" do
    param_group :post
    param_group :location_attributes
  end
  def show
    render json: @post, status: 200, data: @posts
  end

  api :POST, "/api/v1/users/:user_id/posts", "Create post "
  returns :code => 201, :desc => "Create post" do
  param_group :post
  param_group :location_attributes
  end
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    if @post.save
      render json: @post, status: 201, data: @post
    else
      render json: @post.errors, status: :unprocessable_entity
      end
    end

  # PATCH/PUT /posts/1
  api :PATCH, "/api/v1/users/:user_id/posts/:id", "Update post"
  returns :code => 200, :desc => "Update post" do
    param_group :post
    param_group :location_attributes
  end
  def update
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      render json: @post, status: 200, data: @posts
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  api :DELETE, "/api/v1/users/:user_id/posts/:id", "Delete post"
  returns :code => 204, :desc => "Delete post"
  def destroy
    authorize @post
    @post.destroy
    render json: @post, status: 204
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description, :user_id, :picture, :tag_names, location_attributes: [:city, :country, :latitude, :longitude ])
    end
end

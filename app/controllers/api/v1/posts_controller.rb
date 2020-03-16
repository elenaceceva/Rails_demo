class Api::V1::PostsController < BaseController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    if (params.has_key? 'user_id')
      @posts = Post.where(user_id: user_id).order('created_at DESC')
      render json: @posts
    else
      @posts = Post.all.order("created_at DESC")
      render json: @posts
    end
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)

    if @post.save
      render json: @post, status: :created, data: @user
    else
      render json: @post.errors, status: :unprocessable_entity

      end
    end

  # PATCH/PUT /posts/1
  def update
    @user = User.find(params[:user_id])
    @post = @user.posts.find(:id)
    if @post.update_attributes(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :description, :user_id, :location_id, location_attributes: [:city, :country, :latitude, :longitude ])
    end
end
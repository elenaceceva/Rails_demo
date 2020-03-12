class Api::V1::PostsController < BaseController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all.order("updated_at DESC")
    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    city = params[:city]
    country = params[:country]
    @location = Location.where(city == :city && country == :country)

    if @location.nil?
      @location = Location.new(post_params[:location_attributes])
      @location.save
    end

    @post = current_user.posts.build(post_params)
    @post.location_id = @location.id
    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
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

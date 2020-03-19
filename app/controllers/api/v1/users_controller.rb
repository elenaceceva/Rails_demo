class Api::V1::UsersController < BaseController
  before_action :doorkeeper_authorize!

  def_param_group :user do
    param :user, Hash, :desc => "User info" do
      param :email, String, :desc => "Email" , :required => true
      param :nickname, String, :desc => "Nickname", :required => true
      param :firstname, String, :desc => "Firstname"
      param :lastname, String, :desc => "Lastname"
      param :location_id, Integer, required: true
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

  api :GET, "/api/v1/users", "Show all users "
  returns :array_of => :user, :code => 200, :desc => "All users"
  def index
    @users = User.all.order("updated_at DESC")
    render json: @users
  end

  api :POST, "/api/v1/users", "Create user "
  returns :code => 201, :desc => "Create user" do
  param_group :user
  param_group :location_attributes
  end
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: 201, data: @user
    else
      render json: @user.errors, status: 422
    end
  end

  api :GET, "/api/v1/users/:user_id", "Show user "
  returns :code => 200, :desc => "Detailed info about the users" do
    param_group :user
    param_group :location_attributes
  end
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  api :PATCH, "/api/v1/users/:user_id", "Update user"
  returns :code => 200, :desc => "Update user" do
    param_group :user
    param_group :location_attributes
  end
  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(user_params)
      render json: @user, status: 200, data: @user
    else
      render json: @user.errors, status: 422
    end
  end

  api :DELETE, "/api/v1/users/:user_id", "Delete user"
  returns :code => 200, :desc => "Delete user"
    def destroy
      @user = User.find(params[:id])
      @user.destroy
    end
  private

  def user_params
    params.require(:user).permit(:email, :password, :nickname, :firstname, :lastname, location_attributes: [:country, :city, :latitude, :longitude ])
  end
end

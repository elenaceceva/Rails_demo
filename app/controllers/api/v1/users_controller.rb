class Api::V1::UsersController < BaseController
  before_action :doorkeeper_authorize!
  def index
    @users = User.all.order("updated_at DESC")
    render json: @users
  end


  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: 201, data: @user
    else
      render json: @user.errors, status: 422
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
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

    def destroy
      @user = User.find(params[:id])
      @user.destroy
    end
  private

  def user_params
    params.require(:user).permit(:email, :password, :nickname, :firstname, :lastname, :location_id, location_attributes: [:country, :city, :latitude, :longitude ])
  end
end

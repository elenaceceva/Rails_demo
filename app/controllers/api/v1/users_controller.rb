class Api::V1::UsersController < BaseController

  def index
    @users = User.all.order("updated_at DESC")
    render json: @users
  end


  def create
    ActiveRecord::Base.transaction do
    @location = Location.where(country: post_params[:location_attributes[:country]], city: post_params[:location_attributes[:city]]).first

    unless @location
      @location = Location.new(post_params[:location_attributes])
      @location.save
    end

    @user.location_id = @location.id
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 201, location: @user
    else
      render json: @user.errors, status: 422
      end
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user, status: 200, location: @user
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

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe 'GET #show' do
    before :each do
      @user = FactoryBot.create(:user)
    end

    it 'assigns the requested user as @user' do
      get :show, params: { id: @user.id} , format: :json
      expect(response.status).to be(200)
      expect(assigns(:user)).to eq @user
    end

    it 'responds with status code 404 if there is no user with the provided id' do
      get :show, id: 404, format: :json
      expect(response.status).to be(404)
    end

    it 'returns json for the requested user' do
      get :show, id: @user.id, format: :json
      expect(JSON['id']).to eq(id: @user.id)
      expect(JSON['email']).to eq(@user.email)
      expect(JSON['nickname']).to eq(@user.nickname)
      expect(JSON['firstname']).to eq(@user.firstname)
      expect(JSON['lastname']).to eq(@user.lastname)
      expect(JSON['location_id']).to eq(@user.location_id)
    end
  end

  describe 'GET #index' do
    before :each do
      User.all.destroy_all
      @users = []
      2.times do
        u = FactoryBot.create(:user)
        @users << u
      end
    end

    it 'assigns the page of users as @users' do
      get :index, params: { page_size: 1 }, format: :json
      expect(response.status).to be(200)
      expect(assigns(:users)).to eq(@users)
    end

    it 'assigns the correct amount of users according to per_page parameter' do
      get :index, params: { page_size: 1 }, format: :json
      expect(response.status).to be(200)
      expect(assigns(:users).count).to eq(1)
    end

    it 'assigns the correct page of users according to page parameter' do
      get :index, params: { page: 2 }, params: { page_size: 1 }, format: :json
      expect(response.status).to be(200)
      expect(assigns(:users).to_ary).to eq([@users[1]])
    end

    it 'returns a json that contains the users' do
      get :index, format: :json
      expect(JSON).to have_key('data')
    end
  end

  describe 'PUT #update' do
    before :each do
      @user = FactoryBot.build(:user)
      @user_hash = { email: 'New Email', password: 'New Password',
                     nickname: 'New Nickname', firstname: 'New First Name', lastname: 'New Last Name',
                     location_attributes: { city: 'New City',
                                            country: 'New Country',
                                            longitude: 12.4556,
                                            latitude: 13.4566 } }
      put :update, id: @user.id, email: @user_hash[:email], password: @user_hash[:password],
          nickname: @user_hash[:nickname], firstname: @user_hash[:firstname], lastname: @user_hash[:lastname],
          city: @user_hash[:location_attributes[:city]], country: @user_hash[:location_attributes[:country]],
          longitude: @user_hash[:location_attributes[:longitude]], latitude: @user_hash[:location_attributes[:latitude]],
          format: :json
    end

    it 'updates user attributes' do
      @user.reload
      expect(@user.email).to eq(@user_hash[:email])
      expect(@user.password).to eq(@user_hash[:password])
      expect(@user.nickname).to eq(@user_hash[:nickname])
      expect(@user.firstname).to eq(@user_hash[:firstname])
      expect(@user.lastname).to eq(@user_hash[:lastname])
      expect(@user.location.city).to eq(@user_hash[:location_attributes[:city]])
      expect(@user.location.country).to eq(@user_hash[:locations_attributes[:country]])
      expect(@user.location.longitude).to eq(@user_hash[:locations_attributes[:longitude]])
      expect(@user.location.latitude).to eq(@user_hash[:locations_attributes[:latitude]])
    end

    it 'responds with status code 200' do
      expect(response.status).to be(200)
    end

    it 'assigns the updated user as @user' do
      expect(assigns(:user).id).to eq(@user.id)
    end
  end

  describe 'POST #create' do
    before :each do
      @user = FactoryBot.build(:user)
      User.all.destroy_all
    end

    it 'creates a new user' do
      expect{
        post :create, email: @user.email, password: @user.password,
             nickname: @user.nickname, firstname: @user.firstname, lastname: @user.lastname,
             city: @user.location.city, country: @user.location.country,
             longitude: @user.location.longitude, latitude: @user.location.latitude,
             format: :json}.to change(User,:count).by(1)
    end

    it 'responds with status code 201' do
      post :create, email: @user.email, password: @user.password,
           nickname: @user.nickname, firstname: @user.firstname, lastname: @user.lastname,
           city: @user.location.city, country: @user.location.country,
           longitude: @user.location.longitude, latitude: @user.location.latitude,
           format: :json
      expect(response.status).to be(201)
    end

    it 'assigns the created user as @user' do
      post :create, email: @user.email, password: @user.password,
           nickname: @user.nickname, firstname: @user.firstname, lastname: @user.lastname,
           city: @user.location.city, country: @user.location.country,
           longitude: @user.location.longitude, latitude: @user.location.latitude,
           format: :json
      expect(assigns(:user).id).to eq(User.last.id)
    end
  end

  describe 'GET #destroy' do
    before :each do
      @user = FactoryBot.build(:user)
    end

    it 'responds with status 204' do
      delete :destroy, params: { id: @user.id }
      expect(response.status).to be(204)
    end
  end
end
require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "POST #create" do

    context "swhen is succesfully saved" do
      it 'is valid' do
        @user = FactoryBot.build(:user)
        expect(@user.valid?).to be true
      end
    end

    context "when is not successfully saved" do
      it 'is not valid without email' do
        @user = User.new(email: "", password: "password",
                                            nickname: "nickn",
                                            location_attributes: {
                                                country: "Macedonia",
                                                city: "Skopje",
                                                longitude: 21.4254,
                                                latitude: 41.9981})
        expect(@user.valid?).to_not be true
      end
      it 'is not valid without password' do
        @user = User.new(email: "example@something.com", password: "",
                         nickname: "nickn",
                         location_attributes: {
                             country: "Macedonia",
                             city: "Skopje",
                             longitude: 21.4254,
                             latitude: 41.9981})
        expect(@user.valid?).to_not be true
      end
      it 'is not valid without nickname' do
        @user = User.new(email: "example@something.com", password: "password",
                         nickname: "",
                         location_attributes: {
                             country: "Macedonia",
                             city: "Skopje",
                             longitude: 21.4254,
                             latitude: 41.9981})
        expect(@user.valid?).to_not be true
      end
    end
  end

  describe 'Get #index' do
    it 'gets users' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /users/:id' do
    before { delete "/users/#{id}" }

    it 'returns status code 204' do
      expect(response.status).to eq(204)
    end
  end

  describe 'GET #destroy' do
    before :each do
      @user = User.new(email: "example@example.com", password: "password",
                       nickname: "nickn",
                       location_attributes: {
                           country: "Macedonia",
                           city: "Skopje",
                           longitude: 21.4254,
                           latitude: 41.9981})
    end
    it 'deletes the user' do
      expect{ delete :destroy, id: @user.id }.to change(User,:count).by(-1)
    end

    it 'responds with status 204' do
      delete :destroy, id: @user.id
    end
  end
end
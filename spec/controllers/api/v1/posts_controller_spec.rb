require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do

  describe "POST #create" do

    context "when is successfully saved" do
      it 'is valid' do
        @post = Post.new(title: "", description: "something",
                         location_attributes: {
                             country: "Macedonia",
                             city: "Skopje",
                             longitude: 21.4254,
                             latitude: 41.9981})
      end
    end

    context "when is not successfully saved" do
      it 'is not valid without title' do
        @post = Post.new(title: "", description: "something",
                                            location_attributes: {
                                                country: "Macedonia",
                                                city: "Skopje",
                                                longitude: 21.4254,
                                                latitude: 41.9981})
        expect(@post.valid?).to_not be true
      end
      it 'is not valid without description' do
        @post = Post.new(title: "something", description: "",
                         location_attributes: {
                             country: "Macedonia",
                             city: "Skopje",
                             longitude: 21.4254,
                             latitude: 41.9981})
        expect(@post.valid?).to_not be true
      end
    end
  end

  describe 'Get #index' do
    it 'gets posts' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #show' do
    before :each do
      @post = Post.create(title: "title", description: "something",
                          user_id: "1",
                          location_attributes: {
                              country: "Macedonia",
                              city: "Skopje",
                              longitude: 21.4254,
                              latitude: 41.9981})
    end

    it 'assigns the requested post as @post' do
      get :show, id: @post.id, format: :json
      expect(response.status).to be(200)
      expect(assigns(:medicine)).to eq @post
    end

    it 'responds with status code 404 if there is no post with the provided id' do
      get :show, id: 404, format: :json
      expect(response.status).to be(404)
    end
    end

  describe 'GET #destroy' do
    context "success" do
      before :each do
        @post = Post.create(title: "title", description: "something",
                            user_id: "1",
                            location_attributes: {
                                country: "Macedonia",
                                city: "Skopje",
                                longitude: 21.4254,
                                latitude: 41.9981})
      end
      it 'removes post from table' do
        expect { delete :destroy, id: @post }.to change { Post.count }.by(-1)
      end
    end
  end
end
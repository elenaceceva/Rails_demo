require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do

  describe "checks if post is valid" do

    context "when is successfully saved" do
      it 'is valid' do
        @post = Post.new(title: "title", description: "something",
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
  describe 'GET #show' do
    before :each do
      @post = create(:post)
    end

    it 'assigns the requested post as @post' do
      get :show, id: @post.id, format: :json
      expect(response.status).to be(200)
      expect(assigns(:post)).to eq @post
    end

    it 'responds with status code 404 if there is no post with the provided id' do
      get :show, id: 404, format: :json
      expect(response.status).to be(404)
    end

    it 'returns json for the requested post' do
      get :show, id: @post.id, format: :json
      expect(json['id']).to eq(@post.id)
      expect(json['title']).to eq(@post.title)
      expect(json['description']).to eq(@post.description)
      expect(json['user_id']).to eq(@post.user_id)
      expect(json['location_id']).to eq(@post.location_id)
    end
  end

  describe 'GET #index' do
    before :each do
      Post.all.destroy_all
      @posts = []
      2.times do
        p = create(:post)
        @posts << p
      end
    end

    it 'assigns the page of posts as @posts' do
      get :index, page_size: 1, format: :json
      expect(response.status).to be(200)
      expect(assigns(:posts)).to eq(@posts)
    end

    it 'assigns the correct amount of posts according to per_page parameter' do
      get :index, page_size: 1, format: :json
      expect(response.status).to be(200)
      expect(assigns(:posts).count).to eq(1)
    end

    it 'assigns the correct page of posts according to page parameter' do
      get :index, page: 2, page_size: 1, format: :json
      expect(response.status).to be(200)
      expect(assigns(:posts).to_ary).to eq([@posts[1]])
    end

    it 'returns a json that contains the posts' do
      get :index, format: :json
      expect(json).to have_key('data')
    end
  end

  describe 'PUT #update' do
    before :each do
      @post = create(:post)
      @post_hash = { title: 'New Title', description: 'New Description',
                     location_attributes: { city: 'New City',
                                            country: 'New Country',
                                            longitude: 12.4556,
                                            latitude: 13.4566 } }
      put :update, id: post.id, title: @post_hash[:title], description: @post_hash[:description],
          city: @post_hash[:location_attributes[:city]], country: @post_hash[:location_attributes[:country]],
          longitude: @post_hash[:location_attributes[:longitude]], latitude: @post_hash[:location_attributes[:latitude]],
          format: :json
    end

    it 'updates post attributes' do
      @post.reload
      expect(@post.title).to eq(@post_hash[:title])
      expect(@post.description).to eq(@post_hash[:description])
      expect(@post.location.city).to eq(@post_hash[:location_attributes[:city]])
      expect(@post.location.country).to eq(@post_hash[:locations_attributes[:country]])
      expect(@post.location.longitude).to eq(@post_hash[:locations_attributes[:longitude]])
      expect(@post.location.latitude).to eq(@post_hash[:locations_attributes[:latitude]])
    end

    it 'responds with status code 200' do
      expect(response.status).to be(200)
    end

    it 'assigns the updated post as @post' do
      expect(assigns(:post).id).to eq(@post.id)
    end
  end

  describe 'POST #create' do
    before :each do
      @post = build(:post)
      Post.all.destroy_all
    end

    it 'creates a new post' do
      expect{
        post :create, title: @post.title, description: @post.description, user_id: @post.user_id,
             city: @post.location.city, country: @post.location.country,
             longitude: @post.location.longitude, latitude: @post.location.latitude,
             format: :json}.to change(Post,:count).by(1)
    end

    it 'responds with status code 201' do
      post :create, title: @post.title, description: @post.description, user_id: @post.user_id,
           city: @post.location.city, country: @post.location.country,
           longitude: @post.location.longitude, latitude: @post.location.latitude,
           format: :json
      expect(response.status).to be(201)
    end

    it 'assigns the created post as @post' do
      post :create, title: @post.title, description: @post.description, user_id: @post.user_id,
           city: @post.location.city, country: @post.location.country,
           longitude: @post.location.longitude, latitude: @post.location.latitude,
           format: :json
      expect(assigns(:post).id).to eq(Post.last.id)
    end
  end

  describe 'GET #destroy' do
    before :each do
      @post = create(:post)
    end

    it 'responds with status 204' do
      delete :destroy, id: @post.id
      expect(response.status).to be(204)
    end
  end
end
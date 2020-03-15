class Api::V1::SearchesController < BaseController
  def users_by_nickname
    search do
      @matches = []
      User.all.each do |user|
        if (user.nickname.include? params[:nickname])
          matches << user
        end
      end
      @matches
    end
  end

  def users_by_location
    search do
      @users = []
      @locations = Location.within(10, :origin => [params[:latitude], params[:longitude]])
      @locations.each do |location|
        @users << location.users
      end
      @users.flatten
    end
  end

  def posts_by_title
    search do
      @matches = []
      Post.all.each do |post|
        if (post.title.include? params[:title])
          @matches << post
        end
      end
      @matches
    end
  end

  def posts_by_location
    search do
      @posts = []
      @locations = Location.within(10, :origin => [params[:latitude], params[:longitude]])
      @locations.each do |location|
        @posts << location.posts
      end
      @posts.flatten
    end
  end

  private

  def search(&block)
    if params[:q]
      @results = yield if block_given?
      render json: @results
    else
      redirect_to root_url, :notice => 'No search query was specified.'
    end
  end

end

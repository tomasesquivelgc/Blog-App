class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @userPosts = @user.recent_posts
  end

  def show
  
  end
end

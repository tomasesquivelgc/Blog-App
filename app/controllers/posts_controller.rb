class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @userPosts = @user.posts
  end

  def show
  
  end
end

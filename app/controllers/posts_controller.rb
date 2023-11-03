class PostsController < ApplicationController
  def index
    @userPosts = User.find(params[:user_id]).posts
  end

  def show
  
  end
end

class LikesController < ApplicationController
  def create
    post_id = params[:post_id]
    user = Post.find(post_id).author

    # Check if the user has already liked the post
    existing_like = Like.find_by(user: current_user, post_id: post_id)

    if existing_like
      # User has already liked the post, so this is a dislike action
      existing_like.destroy
      flash[:success] = 'Disliked'
    else
      # User hasn't liked the post, create a new like
      like = Like.new(user: current_user, post_id: post_id)
      if like.save
        flash[:success] = 'Liked'
      else
        flash.now[:error] = "Error: Can't like this post"
      end
    end

    redirect_to user_posts_path(user.id)
  end

  def destroy
    post_id = params[:post_id]
    user = Post.find(post_id).author

    # Find the like by the current user for the specified post
    like = Like.find_by(user: current_user, post_id: post_id)

    if like
      # If the like exists, destroy it (unlike)
      like.destroy
      flash[:success] = 'Disliked'
    else
      flash.now[:error] = "Error: Can't dislike this post"
    end

    redirect_to user_posts_path(user.id)
  end
end

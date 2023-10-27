# spec/models/like_spec.rb

require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "Associations" do
    it "belongs to a user with the correct foreign key" do
      user = User.create(name: "John")
      post = Post.create(title: "Test Post", author: user)
      like = Like.create(user: user, post: post)
      expect(like.user).to eq(user)
    end

    it "belongs to a post with the correct foreign key" do
      user = User.create(name: "Alice")
      post = Post.create(title: "Test Post", author: user)
      like = Like.create(user: user, post: post)
      expect(like.post).to eq(post)
    end
  end

  describe "Update Likes Counter" do
    it "updates post's likes_counter when a like is created" do
      user = User.create(name: "John")
      post = Post.create(title: "Test Post", author: user)
      Like.create(user: user, post: post)
      post.reload
      expect(post.likes_counter).to eq(1)
    end

    it "updates post's likes_counter when a like is destroyed" do
      user = User.create(name: "John")
      post = Post.create(title: "Test Post", author: user)
      like = Like.create(user: user, post: post)
      like.destroy
      post.reload
      expect(post.likes_counter).to eq(0)
    end
  end
end

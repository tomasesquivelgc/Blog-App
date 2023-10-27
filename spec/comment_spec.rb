# spec/models/comment_spec.rb

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it 'belongs to a user' do
      user = User.create(name: 'John')
      post = Post.create(title: 'Test Post', author: user)
      comment = Comment.create(text: 'Nice post', post:, user:)
      expect(comment.user).to eq(user)
    end

    it 'belongs to a post' do
      user = User.create(name: 'Alice')
      post = Post.create(title: 'Test Post', author: user)
      comment = Comment.create(text: 'Nice post', post:, user:)
      expect(comment.post).to eq(post)
    end
  end

  describe 'Update Comments Counter' do
    it "updates post's comments_counter when a comment is created" do
      user = User.create(name: 'John')
      post = Post.create(title: 'Test Post', author: user)
      Comment.create(text: 'Nice post', post:, user:)
      post.reload
      expect(post.comments_counter).to eq(1)
    end

    it "updates post's comments_counter when a comment is destroyed" do
      user = User.create(name: 'John')
      post = Post.create(title: 'Test Post', author: user)
      comment = Comment.create(text: 'Nice post', post:, user:)
      comment.destroy
      post.reload
      expect(post.comments_counter).to eq(0)
    end
  end
end

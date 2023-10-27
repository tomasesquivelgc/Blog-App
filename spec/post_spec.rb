# spec/models/post_spec.rb

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it 'belongs to an author with the correct foreign key' do
      user = User.create(name: 'John')
      post = Post.create(title: 'Test Post', author: user)
      expect(post.author).to eq(user)
    end

    it 'has many comments with the correct foreign key' do
      user = User.create(name: 'Alice')
      post = Post.create(title: 'Test Post', author: user)
      comment = Comment.create(text: 'Nice post', post:, user:)
      expect(post.comments).to include(comment)
    end

    it 'has many likes with the correct foreign key' do
      user = User.create(name: 'Bob')
      post = Post.create(title: 'Test Post', author: user)
      like = Like.create(post:, user:)
      expect(post.likes).to include(like)
    end
  end

  describe 'Validations' do
    it 'validates presence of title' do
      post = Post.new
      expect(post.valid?).to be false
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'validates maximum length of title' do
      post = Post.new(title: 'a' * 251)
      expect(post.valid?).to be false
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'validates numericality of comments_counter' do
      post = Post.new(comments_counter: 'invalid')
      expect(post.valid?).to be false
      expect(post.errors[:comments_counter]).to include('is not a number')
    end

    it 'validates comments_counter as an integer' do
      post = Post.new(comments_counter: 5.5)
      expect(post.valid?).to be false
      expect(post.errors[:comments_counter]).to include('must be an integer')
    end

    it "doesn't allow nil for comments_counter" do
      post = Post.new(comments_counter: nil)
      expect(post.valid?).to be false
    end

    it 'validates comments_counter as greater than or equal to 0' do
      post = Post.new(comments_counter: -1)
      expect(post.valid?).to be false
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end

    it 'validates numericality of likes_counter' do
      post = Post.new(likes_counter: 'invalid')
      expect(post.valid?).to be false
      expect(post.errors[:likes_counter]).to include('is not a number')
    end

    it 'validates likes_counter as an integer' do
      post = Post.new(likes_counter: 5.5)
      expect(post.valid?).to be false
      expect(post.errors[:likes_counter]).to include('must be an integer')
    end

    it "doesn't allow nil for likes_counter" do
      post = Post.new(likes_counter: nil)
      expect(post.valid?).to be false
    end

    it 'validates likes_counter as greater than or equal to 0' do
      post = Post.new(likes_counter: -1)
      expect(post.valid?).to be false
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe 'Update User Posts Counter' do
    it "updates user's post_counter when a post is saved" do
      user = User.create(name: 'John')
      Post.create(title: 'Test Post', author: user)
      user.reload
      expect(user.post_counter).to eq(1)
    end

    it "updates user's post_counter when a post is destroyed" do
      user = User.create(name: 'John')
      post = Post.create(title: 'Test Post', author: user)
      post.destroy
      user.reload
      expect(user.post_counter).to eq(0)
    end
  end

  describe 'Recent Comments' do
    it 'returns the 5 most recent comments' do
      user = User.create(name: 'John')
      post = Post.create(title: 'Test Post', author: user)
      6.times { |i| Comment.create(text: "Comment #{i}", post:, created_at: i.days.ago, user:) }
      recent_comments = post.recent_comments
      expect(recent_comments.size).to eq(5)
      expect(recent_comments.map(&:text)).to eq(['Comment 0', 'Comment 1', 'Comment 2', 'Comment 3', 'Comment 4'])
    end
  end
end

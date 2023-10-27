# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it 'has many posts with the correct foreign key' do
      user = User.create(name: 'John')
      post = Post.create(title: 'Test Post', author: user)
      expect(user.posts).to include(post)
    end

    it 'has many comments with the correct foreign key' do
      user = User.create(name: 'Alice')
      post = Post.create(title: 'Test Post', author: user)
      comment = Comment.create(text: 'Nice post', user:, post:)
      expect(user.comments).to include(comment)
    end

    it 'has many likes with the correct foreign key' do
      user = User.create(name: 'Bob')
      post = Post.create(title: 'Test Post', author: user)
      like = Like.create(user:, post:)
      expect(user.likes).to include(like)
    end
  end

  describe 'Validations' do
    it 'validates presence of name' do
      user = User.new
      expect(user.valid?).to be false
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'validates maximum length of name' do
      user = User.new(name: 'a' * 251)
      expect(user.valid?).to be false
      expect(user.errors[:name]).to include('is too long (maximum is 250 characters)')
    end

    it 'validates numericality of post_counter' do
      user = User.new(post_counter: 'invalid')
      expect(user.valid?).to be false
      expect(user.errors[:post_counter]).to include('is not a number')
    end

    it 'validates post_counter as an integer' do
      user = User.new(post_counter: 5.5)
      expect(user.valid?).to be false
      expect(user.errors[:post_counter]).to include('must be an integer')
    end

    it "doesn't allow nil for post_counter" do
      user = User.new(post_counter: nil)
      expect(user.valid?).to be false
    end

    it 'validates post_counter as greater than or equal to 0' do
      user = User.new(post_counter: -1)
      expect(user.valid?).to be false
      expect(user.errors[:post_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe 'Recent Posts' do
    it 'returns the 3 most recent posts' do
      user = User.create(name: 'Test User')
      older_post = Post.create(title: 'Old Post', author: user, created_at: 5.days.ago)
      newer_post = Post.create(title: 'Newer Post', author: user, created_at: 3.days.ago)
      recent_post = Post.create(title: 'Recent Post', author: user, created_at: 1.day.ago)
      Post.create(title: 'Not Included', author: user, created_at: 10.days.ago)

      recent_posts = user.recent_posts

      expect(recent_posts).to eq([recent_post, newer_post, older_post])
      expect(recent_posts.count).to eq(3)
    end
  end
end

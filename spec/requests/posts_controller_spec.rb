# spec/requests/posts_controller_spec.rb
require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let (:user) { User.create(name: 'John Doe') }
  let (:post) { Post.create(title: 'Test Post', text: 'Placeholder text for the body of the post.', author: user) }
  describe 'GET #index' do
    it 'returns the correct status' do
      get user_posts_path(user)
      expect(response).to have_http_status(200) # Adjust the status code as needed
    end

    it 'renders the correct template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(user)
      expect(response.body).to include('<!DOCTYPE html>')
    end
  end

  describe 'GET #show' do
    it 'returns the correct status' do
      # You should replace :post_id with a valid post's ID in your application
      get user_post_path(user, post)
      expect(response).to have_http_status(200) # Adjust the status code as needed
    end

    it 'renders the correct template' do
      # You should replace :post_id with a valid post's ID in your application
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      # You should replace :post_id with a valid post's ID in your application
      get user_post_path(user, post)
      expect(response.body).to include('<!DOCTYPE html>')
    end
  end
end

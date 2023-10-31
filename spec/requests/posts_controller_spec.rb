# spec/requests/posts_controller_spec.rb
require 'rails_helper'

RSpec.describe PostsController, type: :request do

  describe 'GET #index' do
    it 'returns the correct status' do
      get posts_path
      expect(response).to have_http_status(200) # Adjust the status code as needed
    end

    it 'renders the correct template' do
      get posts_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get posts_path
      expect(response.body).to include('Placeholder text for the index action of PostsController')
    end
  end

  describe 'GET #show' do
    it 'returns the correct status' do
      # You should replace :post_id with a valid post's ID in your application
      get post_path(:post_id)
      expect(response).to have_http_status(200) # Adjust the status code as needed
    end

    it 'renders the correct template' do
      # You should replace :post_id with a valid post's ID in your application
      get post_path(:post_id)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      # You should replace :post_id with a valid post's ID in your application
      get post_path(:post_id)
      expect(response.body).to include('Placeholder text for the show action of PostsController')
    end
  end
end

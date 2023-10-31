# spec/requests/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    it 'returns the correct status' do
      get users_path
      expect(response).to have_http_status(200) # Adjust the status code as needed
    end

    it 'renders the correct template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('<!DOCTYPE html>')
    end
  end

  describe 'GET #show' do
    it 'returns the correct status' do
      # You should replace :user_id with a valid user's ID in your application
      get user_path(:user_id)
      expect(response).to have_http_status(200) # Adjust the status code as needed
    end

    it 'renders the correct template' do
      # You should replace :user_id with a valid user's ID in your application
      get user_path(:user_id)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      # You should replace :user_id with a valid user's ID in your application
      get user_path(:user_id)
      expect(response.body).to include('<!DOCTYPE html>')
    end
  end
end

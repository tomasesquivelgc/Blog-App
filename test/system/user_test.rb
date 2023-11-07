require 'application_system_test_case'
class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @users = User.all
    @user_with_posts = users(:two)
  end
end

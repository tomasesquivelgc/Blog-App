require 'application_system_test_case'
class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @users = User.all
    @user_with_posts = users(:two)
  end

	test 'viewing the User index page' do
    visit users_url

    assert_selector 'h1.title', text: 'Users'

    # Check if the username, profile picture, and number of posts are displayed for each user
    @users.each do |user|
      within('.user-card', text: user.name) do
        assert_selector 'h2.card-name', text: user.name
        assert_selector 'p.counter', text: "Number of posts: #{user.post_counter || 0}"

        # Check if the profile picture is displayed if the user has one
        if user.photo.present?
          assert_selector '.user-image'
        end
    	end
		# Check if clicking on a user redirects to their show page
			within('.user-card', text: user.name) do
				click_on user.name
			end

			assert_current_path user_path(user)
			click_on "back to main page"
		end
	end

	test 'viewing the User show page' do
    # Visit the User show page for a user with posts
    visit user_url(@user_with_posts)

    within('.user-card', text: @user_with_posts.name) do
      # Check if the user's profile picture is displayed
      assert_selector '.user-image' if @user_with_posts.photo.present?
      # Check if the user's name is displayed
      assert_selector 'h2.card-name', text: @user_with_posts.name
      # Check if the number of posts is displayed
      assert_selector 'p.counter', text: "Number of posts: #{@user_with_posts.post_counter || 0}"
    end

  end
end

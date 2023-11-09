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
        assert_selector '.user-image' if user.photo.present?
      end
      # Check if clicking on a user redirects to their show page
      within('.user-card', text: user.name) do
        click_on user.name
      end

      assert_current_path user_path(user)
      click_on 'back to main page'
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

    # Check if the user's bio is displayed
    assert_selector '.user-bio-title', text: 'Bio'
    assert_selector '.user-bio-text', text: @user_with_posts.bio

    # Check if the "Recent Posts" section is displayed
    assert_selector 'h3.title', text: 'Recent Posts'

    # Check if the first 3 posts are displayed
    @user_with_posts.posts.first(3).each do |post|
      within('.info-card', text: "Post ##{post.id} By: #{post.author.name}") do
        assert_selector 'h4.user-post-title', text: post.title
        assert_selector 'p.user-post-text', text: post.text
        assert_selector 'p.counter',
                        text: "Comments: #{post.comments_counter || 0}, Likes: #{post.likes_counter || 0}"

        # Check if clicking a user's post redirects to the post's show page
        find('.user-post-title').click
      end
      assert_current_path user_post_path(@user_with_posts, post)
      visit user_url(@user_with_posts) # Navigate back to the User show page
    end

    # Check if the "See all posts" button is displayed
    assert_selector 'a.user-posts-button', text: 'See all posts'

    # Check if clicking "See all posts" redirects to the user's posts index page
    click_on 'See all posts'
    assert_current_path user_posts_path(@user_with_posts)
  end
end

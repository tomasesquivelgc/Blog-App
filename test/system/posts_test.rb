require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @post = posts(:one)
  end

  test 'visiting the index' do
    visit user_posts_url(@user)

    assert_selector "img[src='#{@user.photo}']"
    assert_selector 'a', text: @user.name
    assert_selector 'p', text: "Number of Posts: #{@user.post_counter}"

    # Test to see if all posts are displayed
    @user.posts.order(created_at: :desc).each do |post|
      within("#post-#{post.id}") do
        assert_selector 'a', text: "Post ##{post.id}"
        assert_selector 'p', text: post.text
        assert_selector 'span', text: "Comments: #{post.comments_counter}"
        assert_selector 'span', text: "Likes: #{post.likes_counter}"
        click_on "Post ##{post.id}"
      end
      assert_current_path user_post_path(@user, post)
      click_on 'Back to Post index'
    end
  end

  test 'visiting the show' do
    visit user_post_url(@user, @post)

    assert_selector 'h3', text: @post.id
    assert_selector 'p', text: @post.text
    assert_selector 'p', text: "Likes: #{@post.likes_counter}"
    click_on 'Like'

    # Test to see if all comments are displayed
    @post.comments.order(created_at: :desc).each do |comment|
      within('.comments-container') do
        assert_selector 'p', text: "Username: #{comment.user.name}, #{comment.text}"
      end
      assert_current_path user_post_path(@user, @post)
    end
  end
end
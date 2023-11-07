require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @post = posts(:one)
  end

  test 'posts index' do
    visit user_posts_url(@user)
  
    assert_selector 'img', class: 'user-image'
    assert_selector 'h2', text: @user.name
    assert_selector 'p', text: "Number of posts: #{@user.post_counter}"
  
    # Test to see if all posts are displayed on the index page
    @user.posts.order(created_at: :desc).each do |post|
      assert_selector '.user-post-title', text: post.title
      assert_selector '.user-post-text', text: post.text
      assert_selector '.counter', text: "Comments: #{post.comments_counter || 0}, Likes: #{post.likes_counter || 0}"
      assert_selector '.comments-card', text: post.recent_comments.reverse.first.text
      click_on post.title
  
      # Check that you are now on the show page for the post
      assert_current_path user_post_path(@user, post)
      click_on 'Back to Post index'
    end
  end
  
  test 'posts show' do
    visit user_post_url(@user, @post)
  
    assert_selector 'p', text: "Post #1 By: John Doe"
    assert_selector '.user-post-title', text: @post.title
    assert_selector '.user-post-text', text: @post.text
    assert_selector '.counter', text: "Comments: #{@post.comments_counter || 0}, Likes: #{@post.likes_counter || 0}"
  
    # Find the .comments-card element
    comments_card = find('.comments-card')
  
    # Within the .comments-card element, check for commentator names and their corresponding text
    within(comments_card) do
      assert_selector('.comment', text: "John Doe: This is the first comment.")
      assert_selector('.comment', text: "Peter Smith: Another comment on the first post.")
      assert_selector('.comment', text: "John Doe: Comment on the second post.")
      assert_selector('.comment', text: "Alice Johnson: Yet another comment on the second post.")
      assert_selector('.comment', text: "Peter Smith: Comment on the third post.")
    end
  
    click_on 'Back to Post index'
  end

end
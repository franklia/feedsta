require 'test_helper'

class UsersFollowedControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_followed_index_url
    assert_response :success
  end

  test "should get unfollow" do
    get users_followed_unfollow_url
    assert_response :success
  end

  test "should get suggest" do
    get users_followed_suggest_url
    assert_response :success
  end

end

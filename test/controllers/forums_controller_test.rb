require 'test_helper'

class ForumsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @forum = forums(:one)
    @activity = activities(:one)
    post user_session_path, params: {user: {
      email:    users(:one).email,
      password: "password"
    }}
  end

  test "should get index" do
    get forums_url
    assert_response :success
  end

  test "should get new" do
    get new_forum_url
    # assert_response :success
    assert_response :redirect
  end

  test "should create forum" do
    assert_difference('Forum.count') do
      post forums_url, params: { forum: { event_id: @forum.event_id, title: @forum.title }, event_id: @forum.event_id }
    end

    assert_redirected_to forum_url(Forum.last)
  end

  test "should show forum" do
    get forum_url(@forum)
    assert_response :success
  end

  test "should get edit" do
    get edit_forum_url(@forum)
    assert_response :success
  end

  test "should update forum" do
    patch forum_url(@forum), params: { forum: { event_id: @forum.event_id, title: @forum.title } }
    assert_redirected_to forum_url(@forum)
  end

  test "should destroy forum" do
    assert_difference('Forum.count', -1) do
      delete forum_url(@forum)
    end

    assert_redirected_to forums_url
  end
end

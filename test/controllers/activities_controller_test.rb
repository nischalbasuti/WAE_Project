require 'test_helper'

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activity = activities(:one)
    post user_session_path, params: {user: {
      email:    users(:one).email,
      password: "password"
    }}
  end

  test "should get index" do
    get activities_url
    assert_response :success
  end

  test "should get new" do
    get new_activity_url
    # assert_response :success
    assert_response :redirect
  end

  test "should create activity" do
    assert_difference('Activity.count') do
      post activities_url, params: { activity: { description: @activity.description, end_time: @activity.end_time, event_id: @activity.event_id, name: @activity.name, start_time: @activity.start_time } }
    end

    assert_redirected_to activity_url(Activity.last)
  end

  test "should show activity" do
    get activity_url(@activity)
    assert_response :success
  end

  test "should get edit" do
    get edit_activity_url(@activity)
    assert_response :success
  end

  test "should update activity" do
    patch activity_url(@activity), params: { activity: { description: @activity.description, end_time: @activity.end_time, event_id: @activity.event_id, name: @activity.name, start_time: @activity.start_time } }
    assert_redirected_to activity_url(@activity)
  end

  test "should destroy activity" do
    assert_difference('Activity.count', -1) do
      delete activity_url(@activity)
    end

    assert_redirected_to activities_url
  end
end

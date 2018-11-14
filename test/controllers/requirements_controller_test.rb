require 'test_helper'

class RequirementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @requirement = requirements(:one)
    @activity = activities(:one)
    post user_session_path, params: {user: {
      email:    users(:one).email,
      password: "password"
    }}
  end

  test "should get index" do
    get requirements_url
    assert_response :success
  end

  test "should get new" do
    get new_requirement_url
    #assert_response :success
    assert_response :redirect
  end

  test "should create requirement" do
    assert_difference('Requirement.count') do
      post requirements_url, params: { requirement: { activity_id: @requirement.activity_id, description: @requirement.description, title: @requirement.title } }
    end

    assert_redirected_to requirement_url(Requirement.last)
  end

  test "should show requirement" do
    get requirement_url(@requirement)
    assert_response :success
  end

  test "should get edit" do
    get edit_requirement_url(@requirement)
    assert_response :success
  end

  test "should update requirement" do
    patch requirement_url(@requirement), params: { requirement: { activity_id: @requirement.activity_id, description: @requirement.description, title: @requirement.title } }
    assert_redirected_to requirement_url(@requirement)
  end

  test "should destroy requirement" do
    assert_difference('Requirement.count', -1) do
      delete requirement_url(@requirement)
    end

    assert_redirected_to requirements_url
  end
end

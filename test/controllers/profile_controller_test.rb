require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)    
  end
  
  test "should update profile" do
    @user = users(:one)
    post profile_update_url(@user), params: { nationality: @user.nationality, department_id: @user.department_id}
    assert_redirected_to user_management_profile_url(@user)
  end				

  test "should get events" do
    get profile_events_url
    # assert_response :success
  end

end

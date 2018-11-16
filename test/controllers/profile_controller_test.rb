require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get events" do
    get profile_events_url
    assert_response :success
  end

end

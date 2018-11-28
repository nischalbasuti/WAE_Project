require 'test_helper'

class Ps1ControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ps1_index_url
    assert_response :success
  end

  test "should get divide" do
    get ps1_divide_url
    # assert_response :success
  end

  test "should get news" do
    get ps1_news_url
    assert_response :success
  end

end

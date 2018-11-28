require 'test_helper'

class DepartmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @department = departments(:one)
    @activity = activities(:one)
    post user_session_path, params: {user: {
      email:    users(:admin).email,
      password: "password"
    }}
  end

  test "should get index" do
    get departments_url
    assert_response :success
  end

  test "should get new" do
    get new_department_url
    assert_response :success
  end

  test "should validate on create department" do
    assert_difference( 'Department.count', 0) do
      post departments_url, params: { department: {
      code: "", name: "" } }
    end
    assert_response :success
    assert_select 'li', 'Name has already been taken'
  end

  test "should create department" do
    assert_difference('Department.count') do
      post departments_url, params: { department: { 
        code: @department.code, name: 'CSIM' } }
    end
    assert_redirected_to department_url(Department.last)
  end

  test "should show department" do
    get department_url(@department)
    assert_response :success
  end

  test "should get edit" do
    get edit_department_url(@department)
    assert_response :success
  end

  test "should update department" do
    patch department_url(@department), params: { department: { 
      code: @department.code, name: 'CSIM' } }
    assert_redirected_to department_url(@department)
  end

  test "should not update department" do
    patch department_url(@department), params: { department: { 
      code: "", name: "" } }
    # assert_redirected_to department_url(@department)
  end

  # test "should validate on update department" do
  #   assert_no_difference( 'Department.count',0) do
  #     post department_url, params: { department: {
  #      code: @department.code, name: @department.name } }
  #   end
  #   # assert_response :success
  #   # assert_select 'li', 'Name has already been taken'

  #   # @department2 = departments[:two]
  #   # patch department_url(@department), params: { department: { 
  #   #   code: @department2.code, name: @department2.name } }
  #   # assert_response :success
  #   # assert_select 'li', 'Name has already been taken'
  # end

  # test "should validate on update department" do
  #   @department2 = departments[:two]
  #   patch department_url(@department), params: { department: {
  #     code: @department2.code, name: @department2.name } }
  #   assert_response :success
  #   assert_select 'li', 'Number has already been taken'
  # end

  
  test "should destroy department" do
    assert_difference('Department.count', -1) do
      delete department_url(@department)
    end
    assert_redirected_to departments_url
  end
end

require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase
  test "should get employee_home" do
    get :employee_home
    assert_response :success
  end

  test "should get employee_update" do
    get :employee_update
    assert_response :success
  end

end

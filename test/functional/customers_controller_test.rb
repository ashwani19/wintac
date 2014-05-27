require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  test "should get customer_home" do
    get :customer_home
    assert_response :success
  end

  test "should get customer_update" do
    get :customer_update
    assert_response :success
  end

end

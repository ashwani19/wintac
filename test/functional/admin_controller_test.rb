require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get manage_user" do
    get :manage_user
    assert_response :success
  end

end

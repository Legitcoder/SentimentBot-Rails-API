require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get api/users" do
    get users_api/users_url
    assert_response :success
  end

end

require "test_helper"

class AuthsControllerTest < ActionDispatch::IntegrationTest
  test "should get signin" do
    get auths_signin_url
    assert_response :success
  end

  test "should get signup" do
    get auths_signup_url
    assert_response :success
  end

  test "should get verify" do
    get auths_verify_url
    assert_response :success
  end

  test "should get logout" do
    get auths_logout_url
    assert_response :success
  end
end

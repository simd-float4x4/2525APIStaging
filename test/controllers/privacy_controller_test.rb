require "test_helper"

class PrivacyControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get privacy_new_url
    assert_response :success
  end

  test "should get create" do
    get privacy_create_url
    assert_response :success
  end
end

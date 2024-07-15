require "test_helper"

class TermControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get term_new_url
    assert_response :success
  end

  test "should get create" do
    get term_create_url
    assert_response :success
  end
end

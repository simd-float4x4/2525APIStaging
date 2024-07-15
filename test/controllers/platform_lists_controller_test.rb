require "test_helper"

class PlatformListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @platform_list = platform_lists(:one)
  end

  test "should get index" do
    get platform_lists_url, as: :json
    assert_response :success
  end

  test "should create platform_list" do
    assert_difference("PlatformList.count") do
      post platform_lists_url, params: { platform_list: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show platform_list" do
    get platform_list_url(@platform_list), as: :json
    assert_response :success
  end

  test "should update platform_list" do
    patch platform_list_url(@platform_list), params: { platform_list: {  } }, as: :json
    assert_response :success
  end

  test "should destroy platform_list" do
    assert_difference("PlatformList.count", -1) do
      delete platform_list_url(@platform_list), as: :json
    end

    assert_response :no_content
  end
end

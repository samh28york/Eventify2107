require "test_helper"

class GuestListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get guest_lists_index_url
    assert_response :success
  end
end
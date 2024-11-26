require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create a user with valid attributes
    @user = User.create!(
     first_name: "user",
     last_name: "name",
     email: "guest@example.com",
     password: "password"
   )
   
   post user_sessions_path, params: { email: @user.email, password: "password" }
   assert_response :redirect # Ensure login was successful
   follow_redirect!
 end

  # Test for the index page
  test "should get index" do
    get root_url
    assert_response :success
  end

end

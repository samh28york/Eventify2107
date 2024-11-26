require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create a user with valid attributes
    @user = User.create!(
     first_name: "user",
     last_name: "name",
     email: "guest@example.com",
     password: "password"
   )
  end

  # Test for rendering user login form
  test "should get new_guest" do
    get new_session_path
    assert_response :success
  end

  # Test for successful user login
  test "should log in guest and redirect to guest home" do
    post user_sessions_path, params: { email: @user.email, password: @user.password }

    assert_redirected_to root_path
    assert_equal "Logged in successfully.", flash[:notice]
    assert_equal @user.id, session[:user_id]
  end

  # Test for failed user login
  test "should not log in user and render new_guest if invalid" do
    post new_session_path, params: { email: @user.email, password: "wrongpassword" }

    assert_template :new
    assert_equal "Invalid email or password", flash.now[:alert]
  end
end
